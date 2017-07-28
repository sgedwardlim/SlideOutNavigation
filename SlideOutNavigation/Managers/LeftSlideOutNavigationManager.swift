//
//  LeftSlideOutNavigationManager.swift
//  sturdy
//
//  Created by Edward on 7/17/17.
//  Copyright © 2017 Edward. All rights reserved.
//

import Foundation

public struct LeftSlideOutNavigationEvents {
    let menuItemSelection = Event()
}

public protocol LeftSlideOutNavigationManagerProtocol {
    static var shared: LeftSlideOutNavigationManagerProtocol { get }
    var events: LeftSlideOutNavigationEvents { get }
    
    var sections: [LeftSlideOutMenuSection] { get }
    var menuItems: [LeftSlideOutMenuItem] { get }
    var dict: [String: UIViewController] { get }

    func update(leftSlideOutMenuSections: [LeftSlideOutMenuSection])
    func mapToViewController(viewTitle: String) -> UIViewController
    func menuItemSelection(viewTitle: String)
}

public class LeftSlideOutNavigationManager: LeftSlideOutNavigationManagerProtocol {
    public static var shared: LeftSlideOutNavigationManagerProtocol = LeftSlideOutNavigationManager()
    public let events: LeftSlideOutNavigationEvents = LeftSlideOutNavigationEvents()
    
    public private(set) var sections: [LeftSlideOutMenuSection] = []
    public private(set) var menuItems: [LeftSlideOutMenuItem] = []
    public private(set) var dict: [String: UIViewController] = [:]
    
    private init() {
        
    }
    
    public func update(leftSlideOutMenuSections: [LeftSlideOutMenuSection]) {
        var sections: [LeftSlideOutMenuSection] = []
        var menuItems: [LeftSlideOutMenuItem] = []
        for section in leftSlideOutMenuSections {
            sections.append(section)
            for item in section.items {
                if dict[item.viewTitle] != nil {
                    // perhaps instead of fatalerror we can just test for it via unit testing
                    fatalError("ERROR: \"\(item.viewTitle)\" is already used as a key for \(dict[item.viewTitle]!) and cannot be used for \(item.viewController)")
                }
                dict[item.viewTitle] = item.viewController
                menuItems.append(item)
            }
        }
        self.sections = sections
        self.menuItems = menuItems
    }
    
    public func mapToViewController(viewTitle: String) -> UIViewController {
        guard let vc = dict[viewTitle] else {
            fatalError("ERROR: \(viewTitle) did not map to any existing View Controllers in LeftSlideOutNavigationManager")
        }
        return vc
    }
    
    public func menuItemSelection(viewTitle: String) {
        let viewController = mapToViewController(viewTitle: viewTitle)
        SlideOutNavigationManager.shared.update(mainViewController: viewController)
        events.menuItemSelection.trigger()
    }
}

