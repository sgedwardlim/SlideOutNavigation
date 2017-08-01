//
//  SlideOutNavigationViewController.swift
//  sturdy
//
//  Created by Edward on 7/19/17.
//  Copyright © 2017 Edward. All rights reserved.
//

import UIKit

public final class SlideOutNavigationBarItemProperties {
    // titleLabel properties
    static var title: String = ""
    static var titleAlignment: NSTextAlignment = .left
    static var titleFont: UIFont = UIFont.boldSystemFont(ofSize: 16)
    static var titleColor: UIColor = .black
    
    // leftMenuBarButtonItem properties
    static var leftMenuButtonTintColor: UIColor = .black
    static var leftMenuButtonImage: UIImage = #imageLiteral(resourceName: "menu")
    static var leftMenuButtonStyle: UIBarButtonItemStyle = .plain
    
    // rightMenuBarButtonItem properties
    static var rightMenuButtonTintColor: UIColor = .black
    static var rightMenuButtonImage: UIImage? = nil
    static var rightMenuButtonStyle: UIBarButtonItemStyle = .plain
}

public class SlideOutNavigationController: UINavigationController {
    private let navigationManager: SlideOutNavigationManagerProtocol
    private var leftNavigationViewController: LeftSlideOutNavigationViewController
    
    private let animator = PresentLeftSlideOutAnimator()
    
    // MARK: - Setup
    public init(mainViewController: UIViewController, leftViewController: UIViewController, rightViewController: UIViewController?) {
        navigationManager = SlideOutNavigationManager.shared
        navigationManager.update(mainViewController: mainViewController, leftViewController: leftViewController, rightViewController: rightViewController)
        leftNavigationViewController = LeftSlideOutNavigationViewController()
        super.init(nibName: nil, bundle: nil)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        updateRootViewController()
        navigationManager.events.mainViewControllerUpdated.subscribe { [weak self] in
            self?.updateRootViewController()
        }
    }
    
    private func updateRootViewController() {
        self.viewControllers = [navigationManager.mainViewController]
        navigationManager.mainViewController.viewDidLoad()
        navigationManager.mainViewController.viewDidAppear(false)
        updateNavigationBarItems()
    }
    
    private func updateNavigationBarItems() {
        setupNavigationBarTitleView()
        setupLeftNavigationBarItems()
        setupRightNavigationBarItems()
        
        navigationBar.isTranslucent = false // doesn't have to be here only set once
    }
    
    
    private func setupNavigationBarTitleView() {
        navigationManager.mainViewController.navigationItem.title = nil
        guard let label = navigationManager.mainViewController.navigationItem.titleView as? UILabel else {
            // may be better to create a copy of this instead of passing the reference, might be dangerous
            navigationManager.mainViewController.navigationItem.titleView = titleLabel
            return
        }
        label.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 40)
    }
    
    private func setupLeftNavigationBarItems() {
        guard let leftMenuButton = navigationManager.mainViewController.navigationItem.leftBarButtonItem else {
            // may be better to create a copy of this instead of passing the reference, might be dangerous
            navigationManager.mainViewController.navigationItem.leftBarButtonItem = self.leftMenuButton
            return
        }
        leftMenuButton.target = self
        leftMenuButton.action = #selector(handleLeftMenuSelection)
    }
    
    private func setupRightNavigationBarItems() {
        guard let rightMenuButton = navigationManager.mainViewController.navigationItem.rightBarButtonItem else {
            // may be better to create a copy of this instead of passing the reference, might be dangerous
            navigationManager.mainViewController.navigationItem.rightBarButtonItem = nil
            return
        }
        rightMenuButton.target = self
        rightMenuButton.action = #selector(handleRightMenuSelection)
    }
    
    // MARK: - UIBarButtonItem Components
    private var titleLabel: UILabel {
        get {
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 40))
            label.text = SlideOutNavigationBarItemProperties.title
            label.font = SlideOutNavigationBarItemProperties.titleFont
            label.textAlignment = SlideOutNavigationBarItemProperties.titleAlignment
            label.textColor = SlideOutNavigationBarItemProperties.titleColor
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }
    }
    
    private var leftMenuButton: UIBarButtonItem {
        get {
            let button = UIBarButtonItem()
            button.image = SlideOutNavigationBarItemProperties.leftMenuButtonImage
            button.style = SlideOutNavigationBarItemProperties.leftMenuButtonStyle
            button.tintColor = SlideOutNavigationBarItemProperties.leftMenuButtonTintColor
            button.target = self
            button.action = #selector(handleLeftMenuSelection)
            return button
        }
    }
    
    private var rightMenuButton: UIBarButtonItem {
        get {
            let button = UIBarButtonItem()
            button.image = SlideOutNavigationBarItemProperties.rightMenuButtonImage
            button.style = SlideOutNavigationBarItemProperties.rightMenuButtonStyle
            button.tintColor = SlideOutNavigationBarItemProperties.rightMenuButtonTintColor
            button.target = self
            button.action = #selector(handleRightMenuSelection)
            return button
        }
    }
    
    // MARK: - UIBarButtonItem Actions
    func handleLeftMenuSelection() {
        leftNavigationViewController.transitioningDelegate = animator
        present(leftNavigationViewController, animated: true, completion: nil)
    }

    func handleRightMenuSelection() {

    }
}
