//
//  SONMenuViewController.swift
//  SlideOutNavigation
//
//  Created by Edward on 12/21/18.
//

import UIKit

public protocol SONMenuViewControllerDataSource: class {
    func sonMenuViewController(numberOfRows sonMenuViewController: SONMenuViewController) -> Int
    func sonMenuViewController(_ sonMenuViewController: SONMenuViewController, cellForRowAt index: Int) -> SONMenuViewCell
}

public protocol SONMenuViewControllerDelegate: class {
    func sonMenuViewController(_ sonMenuViewController: SONMenuViewController, didSelectRowAt index: Int)
    func sonMenuViewController(willDismiss sonMenuViewController: SONMenuViewController)
    func sonMenuViewController(didDismiss sonMenuViewController: SONMenuViewController)
}

open class SONMenuViewController: UIViewController {
    // MARK: - Properties
    public weak var sonDelegate: SONMenuViewControllerDelegate?
    public weak var sonDataSource: SONMenuViewControllerDataSource? {
        didSet {
            didSetDataSource()
        }
    }
    
    private var lastHighlightedCell: SONMenuViewCell?
    private var lastSelectedCell: SONMenuViewCell?
    
    // MARK: - Initialization
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configuration
    override open func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureScrollViewLayout()
        configureStackViewLayout()
        configureHiddenDismissButton()
    }
    
    private func addSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        view.addSubview(hiddenDismissButton)
    }
    
    func configureScrollViewLayout() {
        if #available(iOS 11.0, *) {
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
            scrollView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        } else {
            scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        }
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: hiddenDismissButton.leftAnchor).isActive = true
    }
    
    private func configureStackViewLayout() {
        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        stackView.leftAnchor.constraint(equalTo: scrollView.leftAnchor).isActive = true
        stackView.rightAnchor.constraint(equalTo: scrollView.rightAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: MenuHelper.menuWidth).isActive = true
    }
    
    private func configureHiddenDismissButton() {
        hiddenDismissButton.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        hiddenDismissButton.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        hiddenDismissButton.leftAnchor.constraint(equalTo: stackView.rightAnchor).isActive = true
        hiddenDismissButton.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
    private func didSetDataSource() {
        stackView.arrangedSubviews.forEach {
            stackView.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }
        let rows = sonDataSource?.sonMenuViewController(numberOfRows: self) ?? 0
        (0 ..< rows).forEach { index in
            guard let view = sonDataSource?.sonMenuViewController(self, cellForRowAt: index) else { return }
            if view.isSelectable {
                let touchDownGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleStackViewCellTouchedSelection))
                touchDownGesture.minimumPressDuration = 0
                touchDownGesture.cancelsTouchesInView = false
                view.addGestureRecognizer(touchDownGesture)
            }
            stackView.addArrangedSubview(view)
        }
    }
    
    // MARK: - UIView Elements
    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.bounces = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = .clear
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var hiddenDismissButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(handleHiddenDismissButtonSelection), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Actions
    /**
     The rules for determining the states of the cells.
     
     The rules for determining the states of the cells can be summarized as the following,
     
     *Highlighted*
     - The cell is highlighted as long as the user touchesDown when selecting a cell.
     - The cell is highlighted as long as the user initally touchesDown and never touchesUp when selecting a cell.
     
     *Selected*
     - The cell is selected as long as the user touchesUp when selecting the cell that was initially highlighted **and**
     the location of touchesUp is still within the highlighted cell.
     - The cell **remains** selected if the user highlights an already selected cell and touchesUp gesture triggered is outside
     of the location of the selected cell.
     */
    @objc private func handleStackViewCellTouchedSelection(gesture: UILongPressGestureRecognizer) {
        guard let cell = gesture.view as? SONMenuViewCell else { return }
        switch gesture.state {
        case .began, .changed:
            if lastHighlightedCell != cell {
                cell.setHighlighted(true)
                lastHighlightedCell = cell
            }
        case .ended:
            if let index = stackView.arrangedSubviews.firstIndex(where: { gesture.view == $0 }) {
                if lastSelectedCell == cell && cell.frame.contains(gesture.location(in: stackView)) { // Cell currently highlighted is the cell that was previously selected and touchUp gesture received was within the highlighted cell bounds
                    cell.setHighlighted(false)
                    cell.setSelected(true)
                    sonDelegate?.sonMenuViewController(self, didSelectRowAt: index)
                    lastHighlightedCell = nil
                } else if lastSelectedCell == cell { // Cell currently highlighted is the cell that was previously selected and touchUp gesture received was not within the highlighted cell bounds
                    cell.setHighlighted(false)
                    cell.setSelected(true)
                    lastHighlightedCell = nil
                } else if cell.frame.contains(gesture.location(in: stackView)) { // There were no cells selected prior to touchUp gesture received that was within the highlighted cells bounds
                    lastSelectedCell?.setSelected(false)
                    cell.setHighlighted(false)
                    cell.setSelected(true)
                    sonDelegate?.sonMenuViewController(self, didSelectRowAt: index)
                    lastSelectedCell = cell
                    lastHighlightedCell = nil
                } else { // There were no cells selected prior to touchUp gesture received that was outside of the highlighted cells bounds
                    cell.setHighlighted(false)
                    lastHighlightedCell = nil
                }
            }
        default:
            // perhaps we should reset all the states..?
            break
        }
    }
    
    @objc private func handleHiddenDismissButtonSelection() {
        sonDelegate?.sonMenuViewController(willDismiss: self)
        dismiss(animated: true, completion: { [weak self] in
            guard let sself = self else { return }
            sself.sonDelegate?.sonMenuViewController(didDismiss: sself)
        })
    }
    
    /**
     Selects a SONMenuViewCell mimicking a touchDown event.
     
     This is the method that should be used to select a selectable cell. Since this method
     encapsualtes all the complexity around selected cells interaction.
    */
    public func setSelected(cell: SONMenuViewCell) {
        if cell.isSelectable {
            lastSelectedCell?.setSelected(false)
            cell.setHighlighted(false)
            cell.setSelected(true)
            lastSelectedCell = cell
            lastHighlightedCell = nil
        }
    }
}
