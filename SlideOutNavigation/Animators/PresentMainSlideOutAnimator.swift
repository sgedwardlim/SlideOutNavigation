//
//  PresentMainSlideOutAnimator.swift
//  sturdy
//
//  Created by Edward on 7/19/17.
//  Copyright © 2017 Edward. All rights reserved.
//

import UIKit

class PresentMainSlideOutAnimator: NSObject, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate {
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let container = transitionContext.containerView
        let menuView = transitionContext.view(forKey: .from)!
        let mainView = transitionContext.view(forKey: .to)!
        
        let menuWidth = container.bounds.width * MenuHelper.menuWidth
        let initMenuX = menuWidth
        let initMainX = container.frame.origin.x
        
        
        let oldSnapshot = mainView.snapshotView(afterScreenUpdates: false)!
        oldSnapshot.tag = MenuHelper.snapshotNumber
        oldSnapshot.isUserInteractionEnabled = false
        
        let blurEffectView = UIVisualEffectView()
        blurEffectView.alpha = 0.8
        blurEffectView.frame = oldSnapshot.frame
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.effect = UIBlurEffect(style: .regular)
        oldSnapshot.addSubview(blurEffectView)
        
        oldSnapshot.frame.origin.x = initMenuX
        menuView.frame.origin.x = initMainX
        
        container.addSubview(menuView)
        container.insertSubview(oldSnapshot, aboveSubview: menuView)
        mainView.isHidden = true
        container.insertSubview(mainView, belowSubview: menuView)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            
            oldSnapshot.frame.origin.x = 0
            menuView.frame.origin.x = -menuWidth
            blurEffectView.effect = nil
            
        }, completion: {_ in
            mainView.isHidden = false
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
}
