//
//  LeftSlideOutNavigationViewController.swift
//  sturdy
//
//  Created by Edward on 7/15/17.
//  Copyright © 2017 Edward. All rights reserved.
//

import UIKit

class LeftSlideOutNavigationViewController: UIViewController {
    private let navigationManager: SlideOutNavigationManagerProtocol
    
    // MARK: - Setup
    init() {
        navigationManager = SlideOutNavigationManager.shared
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        
        addChildViewController()
        navigationManager.events.leftViewControllerUpdated.subscribe { [weak self] in
            self?.addChildViewController()
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
        containerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        containerView.rightAnchor.constraint(equalTo: hiddenDismissButton.leftAnchor).isActive = true
        containerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func addChildViewController() {
        let viewController = navigationManager.leftViewController!
        addChildViewController(viewController)
        containerView.addSubview(viewController.view)
        viewController.view.frame = containerView.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        viewController.didMove(toParentViewController: self)
    }
    
    private func removeChildViewController() {
        let viewController = navigationManager.leftViewController!
        viewController.willMove(toParentViewController: nil)
        viewController.view.removeFromSuperview()
        viewController.removeFromParentViewController()
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
}

