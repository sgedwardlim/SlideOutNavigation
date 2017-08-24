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
    public static var title: String = ""
    public static var titleAlignment: NSTextAlignment = .left
    public static var titleFont: UIFont = UIFont.boldSystemFont(ofSize: 16)
    public static var titleColor: UIColor = .black
    
    // default leftMenuBarButtonItem properties
    public static var leftMenuButtonTintColor: UIColor = .black
    public static var leftMenuButtonImage: UIImage = UIImage(named: "menu", in: bundle, compatibleWith: nil)!
    public static var leftMenuButtonStyle: UIBarButtonItemStyle = .plain
    
    // default rightMenuBarButtonItem properties
    public static var rightMenuButtonTintColor: UIColor = .black
    public static var rightMenuButtonImage: UIImage? = nil
    public static var rightMenuButtonStyle: UIBarButtonItemStyle = .plain
    
    private static var bundle: Bundle {
        return Bundle(for: SlideOutNavigationBarItemProperties.self)
    }
}
