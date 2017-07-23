//
//  SlideOutNavigationManager.swift
//  sturdy
//
//  Created by Edward on 7/21/17.
//  Copyright © 2017 Edward. All rights reserved.
//

import UIKit

struct SlideOutNavigationEvents {
    let mainViewControllerUpdated = Event()
    let leftViewControllerUpdated = Event()
    let rightViewControllerUpdated = Event()
}

protocol SlideOutNavigationManagerProtocol {
    static var shared: SlideOutNavigationManagerProtocol { get }
    var events: SlideOutNavigationEvents { get }
    
    var mainViewController: UIViewController! { get }
    var leftViewController: UIViewController! { get }
    var rightViewController: UIViewController? { get }
    
    func update(mainViewController: UIViewController, leftViewController: UIViewController, rightViewController: UIViewController?)
    func update(mainViewController: UIViewController)
    func update(leftViewController: UIViewController)
    func update(rightViewController: UIViewController?)
}

class SlideOutNavigationManager: SlideOutNavigationManagerProtocol {
    static var shared: SlideOutNavigationManagerProtocol = SlideOutNavigationManager()
    let events: SlideOutNavigationEvents = SlideOutNavigationEvents()
    
    var mainViewController: UIViewController!
    var leftViewController: UIViewController!
    var rightViewController: UIViewController?
    
    private init() {
        
    }
    
    func update(mainViewController: UIViewController, leftViewController: UIViewController, rightViewController: UIViewController?) {
        update(mainViewController: mainViewController)
        update(leftViewController: leftViewController)
        update(rightViewController: rightViewController)
    }
    
    func update(mainViewController: UIViewController) {
        self.mainViewController = mainViewController
        events.mainViewControllerUpdated.trigger()
    }
    
    func update(leftViewController: UIViewController) {
        self.leftViewController = leftViewController
        events.leftViewControllerUpdated.trigger()
    }
    
    func update(rightViewController: UIViewController?) {
        self.rightViewController = rightViewController
        events.rightViewControllerUpdated.trigger()
    }
}


