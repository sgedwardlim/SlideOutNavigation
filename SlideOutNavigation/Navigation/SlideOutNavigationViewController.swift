//
//  SlideOutNavigationViewController.swift
//  sturdy
//
//  Created by Edward on 7/19/17.
//  Copyright © 2017 Edward. All rights reserved.
//

import UIKit

public class SlideOutNavigationController: UINavigationController {
    private(set) var mainViewController: UIViewController
    private let leftViewController: LeftSlideOutMenuViewController
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
        setupNavigationBar()
        update(mainViewController: mainViewController)
    }
    
    private func setupNavigationBar() {
        navigationBar.isTranslucent = false
        navigationBar.shadowImage = SlideOutNavigationBarProperties.border ? nil : UIImage()
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.barTintColor = SlideOutNavigationBarProperties.backgroundColor
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
    }
    
    private func setupNavigationBarTitleView(for mainViewController: UIViewController) {
        if let title = mainViewController.navigationItem.title {
            let newTitleLabel = titleLabel
            newTitleLabel.text = title
            mainViewController.navigationItem.titleView = newTitleLabel
        } else if let label = mainViewController.navigationItem.titleView as? UILabel {
            label.frame = titleLabel.frame
        } else {
            mainViewController.navigationItem.titleView = titleLabel
        }
    }
    
    private func setupLeftNavigationBarItems(for mainViewController: UIViewController) {
        guard let leftMenuButton = mainViewController.navigationItem.leftBarButtonItem else {
            mainViewController.navigationItem.leftBarButtonItem = self.leftMenuButton
            return
        }
        leftMenuButton.target = self
        leftMenuButton.action = #selector(handleLeftMenuSelection)
    }
    
    private func setupRightNavigationBarItems(for mainViewController: UIViewController) {
        guard let rightMenuButton = mainViewController.navigationItem.rightBarButtonItem as? RightMenuButton else {
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
    
    private var rightMenuButton: RightMenuButton {
        get {
            let button = RightMenuButton()
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


public class RightMenuButton: UIBarButtonItem {
    
}
