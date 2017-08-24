//
//  LeftSlideOutNavigationViewController.swift
//  sturdy
//
//  Created by Edward on 7/15/17.
//  Copyright © 2017 Edward. All rights reserved.
//

import UIKit

class LeftSlideOutNavigationViewController: UIViewController {
    private let mainNavigation: SlideOutNavigationController
    private let leftSlideOutMenu: LeftSlideOutMenuViewController
    private let menuManager: LeftSlideOutMenuNavigationProtocol
    
    // MARK: - Setup
    init(_ mainNavigation: SlideOutNavigationController, leftSlideOutMenu: LeftSlideOutMenuViewController) {
        self.mainNavigation = mainNavigation
        self.leftSlideOutMenu = leftSlideOutMenu
        self.menuManager = leftSlideOutMenu.menuManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        addChildViewController()
        menuManager.events.menuItemSelection.subscribe { [weak self] in
            self?.menuItemSelection(viewController: $0)
        }
    }
    
    private func setupViews() {
        view.backgroundColor = .lightGray
        
        setupHiddenDismissButton()
        setupContainerView()
    }
    
    private func setupHiddenDismissButton() {
        view.addSubview(hiddenDismissButton)
        hiddenDismissButton.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        hiddenDismissButton.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        hiddenDismissButton.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        hiddenDismissButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1 - MenuHelper.menuWidth).isActive = true
    }
    
    private func setupContainerView() {
        view.addSubview(containerView)
        containerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        containerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        containerView.rightAnchor.constraint(equalTo: hiddenDismissButton.leftAnchor).isActive = true
    }
    
    private func addChildViewController() {
        addChildViewController(leftSlideOutMenu)
        containerView.addSubview(leftSlideOutMenu.view)
        leftSlideOutMenu.view.translatesAutoresizingMaskIntoConstraints = false
        leftSlideOutMenu.view.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
        leftSlideOutMenu.view.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
        leftSlideOutMenu.view.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        leftSlideOutMenu.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        leftSlideOutMenu.didMove(toParentViewController: self)
    }
    
    // MARK: - UIView Components
    private var hiddenDismissButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(handleDismissSelection), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // MARK: - Actions
    func handleDismissSelection() {
        dismiss(animated: true, completion: nil)
    }
    
    func menuItemSelection(viewController: UIViewController) {
        mainNavigation.update(mainViewController: viewController)
        dismiss(animated: true, completion: nil)
    }
}

