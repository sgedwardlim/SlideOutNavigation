//
//  SlideOutNavigationViewController.swift
//  sturdy
//
//  Created by Edward on 7/19/17.
//  Copyright © 2017 Edward. All rights reserved.
//

import UIKit

protocol SlideOutNavigationProtocol {
    var mainViewController: UIViewController { get }
    var leftViewController: LeftSlideOutMenuViewController { get }
    func update(mainViewController: UIViewController)
}

public class SlideOutNavigationController: UINavigationController, SlideOutNavigationProtocol {
    private(set) var mainViewController: UIViewController
    private(set) var leftViewController: LeftSlideOutMenuViewController
    private var leftNavigationViewController: LeftSlideOutNavigationViewController!
    private let animator = PresentLeftSlideOutAnimator()
    
    // MARK: - Setup
    public init(mainViewController: UIViewController, leftViewController: LeftSlideOutMenuViewController, rightViewController: UIViewController?) {
        self.mainViewController = mainViewController
        self.leftViewController = leftViewController
        super.init(nibName: nil, bundle: nil)
        leftNavigationViewController = LeftSlideOutNavigationViewController(self, leftSlideOutMenu: leftViewController)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        update(mainViewController: mainViewController)
    }
    
    func update(mainViewController: UIViewController) {
        self.mainViewController = mainViewController
        self.viewControllers = [mainViewController]
        mainViewController.viewDidLoad()
        mainViewController.viewDidAppear(false)
        updateNavigationBarItems(for: mainViewController)
    }
    
    private func updateNavigationBarItems(for mainViewController: UIViewController) {
        setupNavigationBarTitleView(for: mainViewController)
        setupLeftNavigationBarItems(for: mainViewController)
        setupRightNavigationBarItems(for: mainViewController)
        
        navigationBar.isTranslucent = false // doesn't have to be here only set once
    }
    
    private func setupNavigationBarTitleView(for mainViewController: UIViewController) {
        mainViewController.navigationItem.title = nil
        guard let label = mainViewController.navigationItem.titleView as? UILabel else {
            // may be better to create a copy of this instead of passing the reference, might be dangerous
            mainViewController.navigationItem.titleView = titleLabel
            return
        }
        label.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 40)
    }
    
    private func setupLeftNavigationBarItems(for mainViewController: UIViewController) {
        guard let leftMenuButton = mainViewController.navigationItem.leftBarButtonItem else {
            // may be better to create a copy of this instead of passing the reference, might be dangerous
            mainViewController.navigationItem.leftBarButtonItem = self.leftMenuButton
            return
        }
        leftMenuButton.target = self
        leftMenuButton.action = #selector(handleLeftMenuSelection)
    }
    
    private func setupRightNavigationBarItems(for mainViewController: UIViewController) {
        guard let rightMenuButton = mainViewController.navigationItem.rightBarButtonItem else {
            // may be better to create a copy of this instead of passing the reference, might be dangerous
            mainViewController.navigationItem.rightBarButtonItem = nil
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
