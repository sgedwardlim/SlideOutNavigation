//
//  SONViewController.swift
//  SlideOutNavigation
//
//  Created by Edward on 12/22/18.
//

import UIKit

public protocol SONControllerDataSource: class {
    func sonController(sonMenuViewControllerForLeftMenuButton sonController: SONController) -> SONMenuViewController
}

public protocol SONControllerDelegate: class {
    func sonController(_ sonController: SONController, willTransitionTo sonMenuViewController: SONMenuViewController)
    func sonController(_ sonController: SONController, didTransitionTo sonMenuViewController: SONMenuViewController)
}

/**
 SlideOutNavigationControll aka SONController can be subclassed to create slide out navigations. This
 while is discouraged in the iOS design guidelines, still has its place in the mobile world.
 
 **Dont's**
 - Do not set navigationItem.leftBarButtonItem to anything other than what it already is
 */
open class SONController: UINavigationController {
    // MARK: - Properties
    public weak var sonDataSource: SONControllerDataSource? {
        didSet {
            didSetSONDataSource()
        }
    }
    public weak var sonDelegate: SONControllerDelegate?
    public var mainViewController: UIViewController? {
        didSet {
            didSetMainViewController()
        }
    }
    open override var navigationItem: UINavigationItem {
        return mainContainerViewController.navigationItem
    }
    
    private var previousMainViewController: UIViewController?
    private var leftSONMenuViewController: SONMenuViewController?
    private let animator = PresentLeftSlideOutAnimator()
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        viewControllers = [mainContainerViewController]
        navigationItem.leftBarButtonItem = leftSONMenuButton
    }
    
    private func configureNavigationBar() {
        navigationBar.isTranslucent = false
        navigationBar.shadowImage = UIImage()
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.barTintColor = .clear
    }
    
    // MARK: -
    private func didSetSONDataSource() {
        leftSONMenuViewController = sonDataSource?.sonController(sonMenuViewControllerForLeftMenuButton: self)
    }
    
    private func didSetMainViewController() {
        guard let mainViewController = mainViewController else { return }
        previousMainViewController?.willMove(toParentViewController: nil)
        previousMainViewController?.view.removeFromSuperview()
        previousMainViewController?.removeFromParentViewController()
        previousMainViewController = mainViewController

        mainContainerViewController.addChildViewController(mainViewController)
        mainViewController.didMove(toParentViewController: mainContainerViewController)
        mainContainerViewController.view.addSubview(mainViewController.view)
    }

    // MARK: - UIView Components
    /**
     This is a container that will contain the mainViewController that will be set. This
     is done so that even if a user sets and attempts to customize the navigationBar from
     within the mainViewController, there will be no effect on the SONViewController. Ultimately
     preserving the integretiy of the SONViewController, which is to always contain a way to navigate
     to the SONMenuViewController
     */
    private let mainContainerViewController: UIViewController = {
        let viewController = UIViewController()
        viewController.view.translatesAutoresizingMaskIntoConstraints = false
        return viewController
    }()
    
    /**
     The left menu button that is used to navigate to the menu.
     
     - *Do not* override the action on the button as it can cause unexpected behaviour,
     instead, use the delegate method instead to observe when the left menu button
     has been selected.
     
     - *Do not* attempt to set navigationItem.leftBarButtonItem to anything else
     */
    private(set) lazy var leftSONMenuButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.image = UIImage(named: "menu", in: Bundle(for: SONController.self), compatibleWith: nil)!
        button.style = .plain
        button.tintColor = .black
        button.target = self
        button.action = #selector(handleLeftSONMenuButtonSelection)
        return button
    }()
    
    // MARK: - UIBarButtonItem Actions
    @objc func handleLeftSONMenuButtonSelection() {
        let viewControllerToTransitionTo: SONMenuViewController
        if let leftSONMenuViewController = leftSONMenuViewController {
            viewControllerToTransitionTo = leftSONMenuViewController
        } else {
            NSLog("WARNING: No SONMenuViewController returned as sonDataSource, defaulting to an empty SONViewController.")
            viewControllerToTransitionTo = SONMenuViewController()
        }
        viewControllerToTransitionTo.transitioningDelegate = animator
        sonDelegate?.sonController(self, willTransitionTo: viewControllerToTransitionTo)
        present(viewControllerToTransitionTo, animated: true, completion: { [weak self, weak viewControllerToTransitionTo] in
            guard let sself = self, let viewController = viewControllerToTransitionTo else { return }
            sself.sonDelegate?.sonController(sself, didTransitionTo: viewController)
        })
    }
}
