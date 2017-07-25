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
    private let leftNavigationManager: LeftSlideOutNavigationManagerProtocol
    
    private let slideOutNavigationController: SlideOutNavigationController
    
//    private let animator = PresentMainSlideOutAnimator()
    
    // MARK: - Setup
    init() {
        navigationManager = SlideOutNavigationManager.shared
        leftNavigationManager = LeftSlideOutNavigationManager.shared
        slideOutNavigationController = navigationManager.slideOutNavigationController
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        
        navigationManager.events.leftViewControllerPriorUpdate.subscribe { [weak self] in
            self?.removeChildViewController()
        }
        
        addChildViewController()
        navigationManager.events.leftViewControllerUpdated.subscribe { [weak self] in
            self?.addChildViewController()
        }
        
        leftNavigationManager.events.menuItemSelection.subscribe { [weak self] in
            self?.menuItemSelection()
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
        containerView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        containerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        containerView.rightAnchor.constraint(equalTo: hiddenDismissButton.leftAnchor).isActive = true
    }
    
    private func addChildViewController() {
        addChildViewController(navigationManager.leftViewController)
        containerView.addSubview(navigationManager.leftViewController.view)
        navigationManager.leftViewController.view.frame = containerView.bounds
        navigationManager.leftViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        navigationManager.leftViewController.didMove(toParentViewController: self)
    }
    
    private func removeChildViewController() {
        navigationManager.leftViewController.willMove(toParentViewController: nil)
        navigationManager.leftViewController.view.removeFromSuperview()
        navigationManager.leftViewController.removeFromParentViewController()
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
    
    func menuItemSelection() {
//        slideOutNavigationController.transitioningDelegate = animator
        dismiss(animated: true, completion: nil)
//        NSLog("slideOutNavigationController: \(slideOutNavigationController)")
//        present(slideOutNavigationController, animated: true, completion: nil)
    }
}

