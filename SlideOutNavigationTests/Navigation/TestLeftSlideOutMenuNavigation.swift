//
//  TestSlideOutNavigationManager.swift
//  SlideOutNavigation
//
//  Created by Edward on 7/31/17.
//  Copyright © 2017 Edward. All rights reserved.
//

import XCTest
@testable import SlideOutNavigation

class TestLeftSlideOutMenuNavigation: XCTestCase {
    private var manager: LeftSlideOutMenuNavigationProtocol!
    
    override func setUp() {
        super.setUp()
        manager = LeftSlideOutMenuNavigation()
    }
    
    func testSectionsUpdated() {
        let section = LeftSlideOutMenuSection(sectionTitle: "sectionTitle", items: [])
        manager.update(leftSlideOutMenuSections: [section])
        XCTAssertEqual(manager.sections[0].sectionTitle, section.sectionTitle)
        XCTAssertEqual(manager.sections[0].items.isEmpty, section.items.isEmpty)
    }
    
    func testMenuItemsUpdated() {
        let menuItemVC = UIViewController()
        let menuItem = LeftSlideOutMenuItem(viewTitle: "menuItem", viewController: menuItemVC)
        let section = LeftSlideOutMenuSection(sectionTitle: "sectionTitle", items: [menuItem])
        manager.update(leftSlideOutMenuSections: [section])
        XCTAssertEqual(manager.sections[0].items[0].viewTitle, menuItem.viewTitle)
        XCTAssertEqual(manager.sections[0].items[0].viewController, menuItem.viewController)
    }
    
    func testMapToCorrespondingViewControllerWithTitle() {
        let menuItemVC = UIViewController()
        let menuItem = LeftSlideOutMenuItem(viewTitle: "menuItem", viewController: menuItemVC)
        let section = LeftSlideOutMenuSection(sectionTitle: "sectionTitle", items: [menuItem])
        manager.update(leftSlideOutMenuSections: [section])
        XCTAssertEqual(manager.mapToViewController(viewTitle: menuItem.viewTitle), menuItemVC)
    }
    
    func testMenuItemSelection() {
        let menuItemVC = UIViewController()
        let menuItem = LeftSlideOutMenuItem(viewTitle: "menuItem", viewController: menuItemVC)
        let section = LeftSlideOutMenuSection(sectionTitle: "sectionTitle", items: [menuItem])
        manager.update(leftSlideOutMenuSections: [section])
        manager.events.menuItemSelection.subscribe {
            XCTAssertEqual($0, menuItem.viewController)
        }
        manager.menuItemSelection(viewTitle: menuItem.viewTitle)
    }
    
}
