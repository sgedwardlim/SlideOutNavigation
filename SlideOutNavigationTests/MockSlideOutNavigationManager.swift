//
//  MockSlideOutNavigationManager.swift
//  SlideOutNavigation
//
//  Created by Edward on 8/1/17.
//  Copyright © 2017 Edward. All rights reserved.
//

import Foundation
@testable import SlideOutNavigation

class MockSlideOutNavigationManager: SlideOutNavigationManagerProtocol {
    let events: SlideOutNavigationEvents = SlideOutNavigationEvents()
    
    var mainViewController: UIViewController!
    var leftViewController: UIViewController!
    var rightViewController: UIViewController?
    
    init() {
        
    }
    
    func update(mainViewController: UIViewController, leftViewController: UIViewController, rightViewController: UIViewController?) {
        
    }
    
    func update(mainViewController: UIViewController) {
        
    }
    
    func update(leftViewController: UIViewController) {
        
    }
    
    func update(rightViewController: UIViewController?) {
        
    }
}
