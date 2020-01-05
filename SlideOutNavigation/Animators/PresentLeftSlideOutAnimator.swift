////
////  PresentLeftSlideOutAnimator.swift
////  Fyttoo
////
////  Created by Edward on 7/15/17.
////  Copyright © 2017 Edward. All rights reserved.
////
//
//import UIKit
//
//class PresentLeftSlideOutAnimator: NSObject, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate {
//    
//    private var isPresenting: Bool = true
//    private var oldSnapshot: UIView!
//    private var blurEffectView: UIVisualEffectView!
//    
//    // MARK: - UIViewControllerAnimatedTransitioning
//    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
//        guard let controller = transitionContext.viewController(forKey: isPresenting ? .to : .from) else { return }
//        
//        if isPresenting {
//            transitionContext.containerView.addSubview(controller.view)
//        }
//        
//        let presentedFrame = transitionContext.finalFrame(for: controller)
//        var dismissedFrame = presentedFrame
//        
//        if isPresenting {
//            dismissedFrame.origin.x = -presentedFrame.width
//        } else {
//            dismissedFrame.origin.x = transitionContext.containerView.frame.size.width
//        }
//        
//        let initialFrame = isPresenting ? dismissedFrame : presentedFrame
//        let finalFrame = isPresenting ? presentedFrame : dismissedFrame
//        
//        let animationDuration = transitionDuration(using: transitionContext)
//        controller.view.frame = initialFrame
//        UIView.animate(withDuration: animationDuration, animations: {
//            controller.view.frame = finalFrame
//        }, completion: { finished in
//            if !self.isPresenting {
//                controller.view.removeFromSuperview()
//            }
//            transitionContext.completeTransition(finished)
//        })
//    }
//    
//    //    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
//    //        NSLog("~~~ aniamte transtiion")
//    //        let container = transitionContext.containerView
//    //        guard let toView = transitionContext.viewController(forKey: .to)?.view, let fromView = transitionContext.viewController(forKey: .from)?.view else {
//    //            NSLog("~~~ some view is nil")
//    //            return }
//    //        let menuView = isPresenting ? toView : fromView
//    //        let mainView = isPresenting ? fromView : toView
//    //
//    //        NSLog("~~~ mainView: \(mainView)")
//    //
//    //        let menuWidth = container.bounds.width * MenuHelper.menuWidth
//    //        let initMenuX = isPresenting ? container.frame.origin.x : menuWidth
//    //        let initMainX = isPresenting ? -menuWidth : container.frame.origin.x
//    //
//    //        if oldSnapshot == nil {
//    //            oldSnapshot = mainView.snapshotView(afterScreenUpdates: false)!
//    //            oldSnapshot.tag = MenuHelper.snapshotNumber
//    //            oldSnapshot.isUserInteractionEnabled = false
//    //
//    //            blurEffectView = UIVisualEffectView()
//    //            blurEffectView.alpha = 0.5
//    //            blurEffectView.frame = oldSnapshot.frame
//    //            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//    //            oldSnapshot.addSubview(blurEffectView)
//    //        }
//    //
//    //        oldSnapshot.frame.origin.x = initMenuX
//    //        menuView.frame.origin.x = initMainX
//    //
//    //
//    //
//    //        container.addSubview(toView)
//    //        container.insertSubview(oldSnapshot, aboveSubview: menuView)
//    //        mainView.isHidden = true
//    ////        container.insertSubview(mainView, belowSubview: menuView)
//    //
//    //        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
//    //
//    //            self.oldSnapshot.frame.origin.x = self.isPresenting ? menuWidth : 0
//    //            menuView.frame.origin.x = self.isPresenting ? 0: -menuWidth
//    //            self.blurEffectView.effect = self.isPresenting ? UIBlurEffect(style: .dark) : nil
//    //
//    //        }, completion: {_ in
//    //            mainView.isHidden = false
//    //            if !self.isPresenting {
//    //              toView.removeFromSuperview()
//    //            }
//    //            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
//    //        })
//    //    }
//    
//    //    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
//    //
//    //    }
//    
//    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
//        return 0.3
//    }
//    
//    // MARK: - UIViewControllerTransitioningDelegate
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
