//
//  PresentLeftSlideOutAnimator.swift
//  Sturdy
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
        let menuView = isPresenting ? transitionContext.view(forKey: .to)! : transitionContext.view(forKey: .from)!
        let mainView = isPresenting ? transitionContext.view(forKey: .from)! : transitionContext.view(forKey: .to)!
        
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

//class PresentLeftSlideOutAnimator: NSObject, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate {
//
//    private var isPresenting: Bool = true
//    private var oldSnapshot: UIView!
//    private var blurEffectView: UIVisualEffectView!
//
//    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
//        let container = transitionContext.containerView
//        let menuView = isPresenting ? transitionContext.view(forKey: .to)! : transitionContext.view(forKey: .from)!
//        let mainView = isPresenting ? transitionContext.view(forKey: .from)! : transitionContext.view(forKey: .to)!
//
//        let menuWidth = container.bounds.width * MenuHelper.menuWidth
//        let initMenuX = isPresenting ? container.frame.origin.x : menuWidth
//        let initMainX = isPresenting ? -menuWidth : container.frame.origin.x
//        let initalCenterXConstant = isPresenting ? menuWidth : 0
//
//        if oldSnapshot == nil {
//            oldSnapshot = mainView.snapshotView(afterScreenUpdates: false)!
//            oldSnapshot.tag = MenuHelper.snapshotNumber
//            oldSnapshot.isUserInteractionEnabled = false
//
//            blurEffectView = UIVisualEffectView()
//            blurEffectView.alpha = 0.5
//            //            blurEffectView.frame = oldSnapshot.frame
//            //            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//            oldSnapshot.addSubview(blurEffectView)
//            blurEffectView.topAnchor.constraint(equalTo: oldSnapshot.topAnchor).isActive = true
//            blurEffectView.bottomAnchor.constraint(equalTo: oldSnapshot.bottomAnchor).isActive = true
//            blurEffectView.leftAnchor.constraint(equalTo: oldSnapshot.leftAnchor).isActive = true
//            blurEffectView.rightAnchor.constraint(equalTo: oldSnapshot.rightAnchor).isActive = true
//        }
//
//        container.addSubview(menuView)
//        container.insertSubview(oldSnapshot, aboveSubview: menuView)
//        mainView.isHidden = true
//        container.insertSubview(mainView, belowSubview: menuView)
//
//        let oldSnapshotCenterXConstant = oldSnapshot.centerXAnchor.constraint(equalTo: container.centerXAnchor, constant: initalCenterXConstant)
//        oldSnapshotCenterXConstant.isActive = true
//        oldSnapshot.topAnchor.constraint(equalTo: container.topAnchor).isActive = true
//        oldSnapshot.bottomAnchor.constraint(equalTo: container.bottomAnchor).isActive = true
//
//        menuView.widthAnchor.constraint(equalToConstant: menuWidth).isActive = true
//        menuView.rightAnchor.constraint(equalTo: oldSnapshot.leftAnchor).isActive = true
//        menuView.topAnchor.constraint(equalTo: container.topAnchor).isActive = true
//        menuView.bottomAnchor.constraint(equalTo: container.bottomAnchor).isActive = true
//
//        //        oldSnapshot.frame.origin.x = initMenuX
//        //        menuView.frame.origin.x = initMainX
//
//        //        container.addSubview(menuView)
//        //        container.insertSubview(oldSnapshot, aboveSubview: menuView)
//        //        mainView.isHidden = true
//        //        container.insertSubview(mainView, belowSubview: menuView)
//
//        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
//
//            //            self.oldSnapshot.frame.origin.x = self.isPresenting ? menuWidth : 0
//            //            menuView.frame.origin.x = self.isPresenting ? 0: -menuWidth
//
//            oldSnapshotCenterXConstant.constant = self.isPresenting ? initalCenterXConstant : 0
//
//            self.blurEffectView.effect = self.isPresenting ? UIBlurEffect(style: .dark) : nil
//
//        }, completion: {_ in
//            mainView.isHidden = false
//            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
//        })
//    }
//
//    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
//        return 0.3
//    }
//
//    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        isPresenting = true
//        oldSnapshot = nil
//        return self
//    }
//
//    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        isPresenting = false
//        return self
//    }
//}
//

