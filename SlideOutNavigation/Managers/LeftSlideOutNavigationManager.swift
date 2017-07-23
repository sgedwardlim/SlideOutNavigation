////
////  LeftSlideOutNavigationManager.swift
////  sturdy
////
////  Created by Edward on 7/17/17.
////  Copyright © 2017 Edward. All rights reserved.
////
//
//import UIKit
//
//struct LeftSlideOutMenuSection {
//    let sectionHeader: String
//    let items: [LeftSlideOutMenuItem]
//}
//
//struct LeftSlideOutMenuItem {
//    let viewTitle: String
//    let viewController: UIViewController
//}
//
//protocol LeftSlideOutNavigationManagerProtocol {
//    var leftViewNavigationController: LeftSlideOutNavigationViewController { get }
//    var leftViewController: UIViewController { get }
//    
//    var sections: [LeftSlideOutMenuSection] { get }
//    var menuItems: [LeftSlideOutMenuItem] { get }
//    var dict: [String: UIViewController] { get }
////    
////    func replace(leftViewController: UIViewController)
////    func update(leftSlideOutMenuSections: [LeftSlideOutMenuSection])
////    func mapToViewControllerWith(viewName: String) -> UIViewController
//    func update(leftViewController: UIViewController)
//    func present(_ viewControllerToPresent: UIViewController, animated: Bool, completion: (() -> Void)?)
//    func dismiss(animated: Bool, completion: (() -> Void)?)
//}
//
//class LeftSlideOutNavigationManager: LeftSlideOutNavigationManagerProtocol {
//    private(set) var leftViewNavigationController: LeftSlideOutNavigationViewController
//    private(set) var leftViewController: UIViewController
//    
//    private(set) var sections: [LeftSlideOutMenuSection] = []
//    private(set) var menuItems: [LeftSlideOutMenuItem] = []
//    private(set) var dict: [String: UIViewController] = [:]
//    
//    init() {
//        self.leftViewController = UIViewController()
//        self.leftViewNavigationController = LeftSlideOutNavigationViewController(leftViewController: leftViewController)
//    }
//    
//    func update(leftViewController: UIViewController) {
//        self.leftViewController.willMove(toParentViewController: nil)
//        self.leftViewController.view.removeFromSuperview()
//        self.leftViewController.removeFromParentViewController()
//        self.leftViewController = leftViewController
//        
//        leftViewNavigationController.addChildViewController(leftViewController)
//        leftViewNavigationController.containerView.addSubview(leftViewController.view)
//        leftViewController.view.frame = leftViewNavigationController.containerView.bounds
//        leftViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        leftViewController.didMove(toParentViewController: leftViewNavigationController)
//    }
//    
//    func present(_ viewControllerToPresent: UIViewController, animated: Bool, completion: (() -> Void)?) {
//        leftViewNavigationController.present(viewControllerToPresent, animated: animated, completion: completion)
//    }
//    
//    func dismiss(animated: Bool, completion: (() -> Void)?) {
//        leftViewNavigationController.dismiss(animated: animated, completion: completion)
//    }
//    
//    func update(leftSlideOutMenuSections: [LeftSlideOutMenuSection]) {
//        var sections: [LeftSlideOutMenuSection] = []
//        var menuItems: [LeftSlideOutMenuItem] = []
//        for section in leftSlideOutMenuSections {
//            sections.append(section)
//            for item in section.items {
//                if dict[item.viewTitle] != nil {
//                    // perhaps instead of fatalerror we can just test for it via unit testing
//                    fatalError("ERROR: \"\(item.viewTitle)\" is already used as a key for \(dict[item.viewTitle]!) and cannot be used for \(item.viewController)")
//                }
//                dict[item.viewTitle] = item.viewController
//                menuItems.append(item)
//            }
//        }
//        NSLog("Initalization of LeftSlideOutMenuSections completed")
//        self.sections = sections
//        self.menuItems = menuItems
//    }
//    
//    func mapToViewControllerWith(viewName: String) -> UIViewController {
//        guard let vc = dict[viewName] else {
//            fatalError("ERROR: \(viewName) did not map to any existings View Controllers in LeftSlideOutNavigationManager")
//        }
//        return vc
//    }
//}

