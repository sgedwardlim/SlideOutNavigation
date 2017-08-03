//
//  Event.swift
//  SlideOutNavigation
//
//  Created by Edward on 7/22/17.
//  Copyright © 2017 Edward. All rights reserved.
//

import Foundation

class Event {
    private let internalEvent = EventWithMetadata<Void?>()
    
    init() {
        
    }
    
    func subscribe(_ callback: @escaping () -> Void) {
        internalEvent.subscribe({ _ in callback() })
    }
    
    func trigger() {
        internalEvent.trigger(withMetada: nil)
    }
}

class EventWithMetadata<T> {
    private var callbacks = ContiguousArray<(T) -> Void>()
    
    init() {
        
    }
    
    func subscribe(_ callback: @escaping (T) -> Void) {
        callbacks.append(callback)
    }
    
    func trigger(withMetada metadata: T) {
        for i in 0..<callbacks.count {
            callbacks[i](metadata)
        }
    }
}
