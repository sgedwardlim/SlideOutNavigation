//
//  TestSlideOutNavigationManager.swift
//  SlideOutNavigation
//
//  Created by Edward on 7/31/17.
//  Copyright © 2017 Edward. All rights reserved.
//

import XCTest
@testable import SlideOutNavigation

class TestSlideOutNavigationManager: XCTestCase {
    private var manager: LeftSlideOutNavigationManagerProtocol!
    
    override func setUp() {
        super.setUp()
        manager = LeftSlideOutNavigationManager.shared
    }
    
    func testSectionsUpdated() {
        let section = LeftSlideOutMenuSection(sectionTitle: "sectionTitle", items: [])
        manager.update(leftSlideOutMenuSections: [section])
    }
    
    func testMenuItemsUpdated() {
        let menuItemVC = UIViewController()
        let menuItem = LeftSlideOutMenuItem(viewTitle: "menuItem", viewController: menuItemVC)
        let section = LeftSlideOutMenuSection(sectionTitle: "sectionTitle", items: [menuItem])
        manager.update(leftSlideOutMenuSections: [section])
        XCTAssertEqual(manager.sections[0].items[0].viewTitle, menuItem.viewTitle)
        XCTAssertEqual(manager.sections[0].items[0].viewController, menuItem.viewController)
    }
    
    func testMapsCorrespondingVewControllerWithTitle() {
        let menuItemVC = UIViewController()
        let menuItem = LeftSlideOutMenuItem(viewTitle: "menuItem", viewController: menuItemVC)
        let section = LeftSlideOutMenuSection(sectionTitle: "sectionTitle", items: [menuItem])
        manager.update(leftSlideOutMenuSections: [section])
        XCTAssertEqual(manager.mapToViewController(viewTitle: menuItem.viewTitle), menuItemVC)
    }
    
    func testMenuItemSelectionUpdatesMainViewController() {
        let menuItemVC = UIViewController()
        let menuItem = LeftSlideOutMenuItem(viewTitle: "menuItem", viewController: menuItemVC)
        let section = LeftSlideOutMenuSection(sectionTitle: "sectionTitle", items: [menuItem])
        manager.update(leftSlideOutMenuSections: [section])
        manager.menuItemSelection(viewTitle: menuItem.viewTitle)
        XCTAssertEqual(SlideOutNavigationManager.shared.mainViewController, menuItemVC)
    }
    
}
