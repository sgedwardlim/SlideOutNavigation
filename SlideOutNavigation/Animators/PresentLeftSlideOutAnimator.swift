//
//  PresentLeftSlideOutAnimator.swift
//  sturdy
//
//  Created by Edward on 7/15/17.
//  Copyright © 2017 Edward. All rights reserved.
//

import UIKit

class PresentLeftSlideOutAnimator: NSObject, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate {
    
    private var isPresenting: Bool = true
    private var oldSnapshot: UIView!
    private var blurEffectView: UIVisualEffectView!
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let container = transitionContext.containerView
        let fromView = transitionContext.view(forKey: .from)!
        let toView = transitionContext.view(forKey: .to)!

        let menuView = isPresenting ? toView : fromView
        let mainView = isPresenting ? fromView : toView
        
        let menuWidth = container.bounds.width * MenuHelper.menuWidth
        let initMenuX = isPresenting ? container.frame.origin.x : menuWidth
        let initMainX = isPresenting ? -menuWidth : container.frame.origin.x
        
        if oldSnapshot == nil {
            oldSnapshot = mainView.snapshotView(afterScreenUpdates: false)!
            oldSnapshot.tag = MenuHelper.snapshotNumber
            oldSnapshot.isUserInteractionEnabled = false
            
            blurEffectView = UIVisualEffectView()
            blurEffectView.alpha = 0.5
            blurEffectView.frame = oldSnapshot.frame
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            oldSnapshot.addSubview(blurEffectView)
        }
        
        oldSnapshot.frame.origin.x = initMenuX
        menuView.frame.origin.x = initMainX
        
        container.addSubview(menuView)
        container.insertSubview(oldSnapshot, aboveSubview: menuView)
        mainView.isHidden = true
        container.insertSubview(mainView, belowSubview: menuView)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            
            self.oldSnapshot.frame.origin.x = self.isPresenting ? menuWidth : 0
            menuView.frame.origin.x = self.isPresenting ? 0: -menuWidth
            self.blurEffectView.effect = self.isPresenting ? UIBlurEffect(style: .dark) : nil
            
        }, completion: {_ in
            mainView.isHidden = false
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresenting = true
        oldSnapshot = nil
        return self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresenting = false
        return self
    }
}
