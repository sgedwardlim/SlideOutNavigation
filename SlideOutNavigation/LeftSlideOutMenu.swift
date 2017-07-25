//
//  LeftSlideOutMenu.swift
//  SlideOutNavigation
//
//  Created by Edward on 7/22/17.
//  Copyright © 2017 Edward. All rights reserved.
//

import Foundation

public struct LeftSlideOutMenuSection {
    public let sectionTitle: String
    public let items: [LeftSlideOutMenuItem]
    
    public init(sectionTitle: String, items: [LeftSlideOutMenuItem]) {
        self.sectionTitle = sectionTitle
        self.items = items
    }
}

public struct LeftSlideOutMenuItem {
    public let viewTitle: String
    public let viewController: UIViewController
    
    public init(viewTitle: String, viewController: UIViewController) {
        self.viewTitle = viewTitle
        self.viewController = viewController
    }
}
