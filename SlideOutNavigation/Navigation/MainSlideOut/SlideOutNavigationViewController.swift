//
//  SlideOutNavigationViewController.swift
//  sturdy
//
//  Created by Edward on 7/19/17.
//  Copyright © 2017 Edward. All rights reserved.
//

import UIKit

public final class SlideOutNavigationController: UINavigationController {
    private let navigationManager: SlideOutNavigationManagerProtocol
    
    private let leftNavigationViewController: LeftSlideOutNavigationViewController
//    private let rightNavigationViewController = RightSlideOutNavigationViewController()
    
    private let animator = PresentLeftSlideOutAnimator()
    
    // MARK: - Setup
    public init(mainViewController: UIViewController, leftViewController: UIViewController, rightViewController: UIViewController?) {
        navigationManager = SlideOutNavigationManager.shared
        leftNavigationViewController = LeftSlideOutNavigationViewController()
//        rightNavigationViewController = RightSlideOutNavigationViewController()
        navigationManager.update(mainViewController: mainViewController, leftViewController: leftViewController, rightViewController: rightViewController)
        super.init(nibName: nil, bundle: nil)
        NSLog("main view from root view controller: \(self.view)")
        NSLog("main view from slideout: \(mainViewController.view)")
        NSLog("INIT FROM SLIDEOUT")
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        
        NSLog("VIEW DID LOAD TRIGGERED")
        updateRootViewController()
        navigationManager.events.mainViewControllerUpdated.subscribe { [weak self] in
            self?.updateRootViewController()
            NSLog("SUBSCRIPTION TRIGGERED")
        }
    }
    
    private func setupNavigationBar() {
        navigationManager.mainViewController.navigationItem.titleView = titleLabel
        navigationManager.mainViewController.navigationItem.leftBarButtonItem = leftMenuButton
        navigationManager.mainViewController.navigationItem.rightBarButtonItem = rightMenuButton
        
        navigationBar.isTranslucent = false // doseent have to be her eonly set once
    }
    
    private func updateRootViewController() {
        let viewController = navigationManager.mainViewController
        self.viewControllers = [viewController!]
        setupNavigationBar()
    }
    
    // MARK: - UIBarButtonItem Components
    private(set) var leftMenuButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: #imageLiteral(resourceName: "menu"), style: .plain, target: self, action: #selector(handleLeftMenuSelection))
        button.tintColor = .black
        return button
    }()
    
    private(set) var titleLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 40, width: 320, height: 40))
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .left
        label.text = "hello world!~~"
        return label
    }()
    
    private(set) var rightMenuButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: nil, style: .plain, target: self, action: #selector(handleRightMenuSelection))
        button.tintColor = .black
        return button
    }()
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return animator
    }
    
    // MARK: - UIBarButtonItem Actions
    func handleLeftMenuSelection() {
        leftNavigationViewController.transitioningDelegate = animator
        present(leftNavigationViewController, animated: true, completion: nil)
    }

    func handleRightMenuSelection() {
        
    }
}
