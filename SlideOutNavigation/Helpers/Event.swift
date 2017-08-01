//
//  Event.swift
//  SlideOutNavigation
//
//  Created by Edward on 7/22/17.
//  Copyright © 2017 Edward. All rights reserved.
//

import Foundation

class Event {
    private var callbacks = ContiguousArray<() -> Void>()
    
    init() {
        
    }
    
    func subscribe(_ callback: @escaping () -> Void) {
        callbacks.append(callback)
    }
    
    func trigger() {
        for i in 0..<callbacks.count {
            callbacks[i]()
        }
    }
}
