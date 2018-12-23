//
//  SONMenuViewCell.swift
//  SlideOutNavigation
//
//  Created by Edward on 12/22/18.
//

import UIKit

/**
 A cell can be represented in a row of the SlideOutNavigationMenu.
 */
open class SONMenuViewCell: UIView {
    /**
     This computed variable determine if a cell is selectable, by default all cells start of as selectable.
     
     Override this computed variable to return false, if the cell is not selectable. When this is set to
     return false, setSelected(_:Bool) and setHighlighted(_:Bool) methods will never be called
     */
    open var isSelectable: Bool { return true }
    
    /**
     This method is called when the cell is highlighted, this is equivalent to a touchDown event on the cell.
     
     When the cell is highlighted, this method will be called with the highlighted parameter set to true, if
     a touchDown gesture was registered on the cell, else the highlighted parameter will be set to false. If
     isSelectable is set to return false, this method will never be called.
     */
    open func setHighlighted(_ highlighted: Bool) {}
    
    /**
     This method is called when the cell is selected, this is equivalent to a touchUp event on the cell.
     
     When the cell is selected, this method will be called with the selected parameter set to true, if
     a touchUp gesture was registered on the cell, else the selected parameter will be set to false. If
     isSelectable is set to return false, this method will never be called.
    */
    open func setSelected(_ selected: Bool) {}
}
