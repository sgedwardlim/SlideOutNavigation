//
//  SlideOutNavigationViewController.swift
//  sturdy
//
//  Created by Edward on 7/19/17.
//  Copyright © 2017 Edward. All rights reserved.
//

import UIKit

public class SlideOutNavigationControllerProperties {
    // Contains all the properties that belong to
    static var titleLabel: String = ""
    static var titleTextAlignment: NSTextAlignment = .left
    static var titleFont: UIFont = UIFont.boldSystemFont(ofSize: 16)
    
    static var leftMenuButtonImage: UIImage = #imageLiteral(resourceName: "menu")
    static var leftMenuButtonTintColor: UIColor = .black
    
    static var rightMenuButtonImage: UIImage = #imageLiteral(resourceName: "menu")
    static var rightMenuButtonTintColor: UIColor = .black
}

public class SlideOutNavigationController: UINavigationController {
    private let navigationManager: SlideOutNavigationManagerProtocol
    private var leftNavigationViewController: LeftSlideOutNavigationViewController!
//    private let rightNavigationViewController = RightSlideOutNavigationViewController()
    private let animator = PresentLeftSlideOutAnimator()
    
    // MARK: - Setup
    public init(mainViewController: UIViewController, leftViewController: UIViewController, rightViewController: UIViewController?) {
        navigationManager = SlideOutNavigationManager.shared
        super.init(nibName: nil, bundle: nil)
        navigationManager.initalize(slideOutNavigationController: self)
        navigationManager.update(mainViewController: mainViewController, leftViewController: leftViewController, rightViewController: rightViewController)
        leftNavigationViewController = LeftSlideOutNavigationViewController()
//        rightNavigationViewController = RightSlideOutNavigationViewController()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        
        updateRootViewController()
        navigationManager.events.mainViewControllerUpdated.subscribe { [weak self] in
            self?.updateRootViewController()
            NSLog("main view controller updated through subscribed")
        }
    }
    
    private func setupNavigationBar() {
        navigationManager.mainViewController.navigationItem.titleView = titleLabel
        navigationManager.mainViewController.navigationItem.leftBarButtonItem = leftMenuButton
        navigationManager.mainViewController.navigationItem.rightBarButtonItem = rightMenuButton
        
        navigationBar.isTranslucent = false // doesn't have to be here only set once
    }
    
    private func updateRootViewController() {
        self.viewControllers = [navigationManager.mainViewController]
        setupNavigationBar()
    }
    
    // MARK: - UIBarButtonItem Components
    private(set) var titleLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 40, width: 320, height: 40))
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .left
        label.text = "hello world!~~"
        return label
    }()
    
    private(set) var leftMenuButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: #imageLiteral(resourceName: "menu"), style: .plain, target: self, action: #selector(handleLeftMenuSelection))
        button.tintColor = .black
        return button
    }()
    
    private(set) var rightMenuButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: nil, style: .plain, target: self, action: #selector(handleRightMenuSelection))
        button.tintColor = .black
        return button
    }()
    
    // MARK: - UIBarButtonItem Actions
    func handleLeftMenuSelection() {
        leftNavigationViewController.transitioningDelegate = animator
        present(leftNavigationViewController, animated: true, completion: nil)
    }

    func handleRightMenuSelection() {
        
    }
}
