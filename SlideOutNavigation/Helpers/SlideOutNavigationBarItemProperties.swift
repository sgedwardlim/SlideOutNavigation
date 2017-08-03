//
//  SlideOutNavigationBarItemProperties.swift
//  SlideOutNavigation
//
//  Created by Edward on 8/3/17.
//  Copyright © 2017 Edward. All rights reserved.
//

import Foundation

public final class SlideOutNavigationBarItemProperties {
    // default titleLabel properties
    static var title: String = ""
    static var titleAlignment: NSTextAlignment = .left
    static var titleFont: UIFont = UIFont.boldSystemFont(ofSize: 16)
    static var titleColor: UIColor = .black
    
    // default leftMenuBarButtonItem properties
    static var leftMenuButtonTintColor: UIColor = .black
    static var leftMenuButtonImage: UIImage = #imageLiteral(resourceName: "menu")
    static var leftMenuButtonStyle: UIBarButtonItemStyle = .plain
    
    // default rightMenuBarButtonItem properties
    static var rightMenuButtonTintColor: UIColor = .black
    static var rightMenuButtonImage: UIImage? = nil
    static var rightMenuButtonStyle: UIBarButtonItemStyle = .plain
}
