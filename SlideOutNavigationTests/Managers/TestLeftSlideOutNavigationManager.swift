//
//  TestLeftSlideOutNavigationManager.swift
//  SlideOutNavigation
//
//  Created by Edward on 7/31/17.
//  Copyright © 2017 Edward. All rights reserved.
//

import XCTest
@testable import SlideOutNavigation

class TestLeftSlideOutNavigationManager: XCTestCase {
    private var manager: SlideOutNavigationManagerProtocol!
    
    override func setUp() {
        super.setUp()
        manager = SlideOutNavigationManager.shared
    }
    
    func testViewControllersUpdated() {
        let mainViewController = UIViewController()
        let leftViewController = UIViewController()
        let rightViewController = UIViewController()
        manager.update(mainViewController: mainViewController, leftViewController: leftViewController, rightViewController: rightViewController)
        XCTAssertEqual(manager.mainViewController, mainViewController)
        XCTAssertEqual(manager.leftViewController, leftViewController)
        XCTAssertEqual(manager.rightViewController, rightViewController)
    }
    
    func testMainViewControllerUpdated() {
        let viewController = UIViewController()
        manager.update(mainViewController: viewController)
        XCTAssertEqual(manager.mainViewController, viewController)
    }
    
    func testLeftViewControllerUpdated() {
        let viewController = UIViewController()
        manager.update(leftViewController: viewController)
        XCTAssertEqual(manager.leftViewController, viewController)
    }
    
    func testRightViewControllerUpdated() {
        let viewController = UIViewController()
        manager.update(rightViewController: viewController)
        XCTAssertEqual(manager.rightViewController, viewController)
    }
}
