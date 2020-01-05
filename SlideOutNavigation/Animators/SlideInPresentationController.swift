//
//  SlideInPresentationController.swift
//  SlideOutNavigation
//
//  Created by Edward on 1/4/20.
//  Copyright © 2020 Edward. All rights reserved.
//

import UIKit

final class SlideInPresentationController: UIPresentationController {
    // MARK: - Properties
    private let direction: PresentationDirection
    
    var presentedViewWidth: CGFloat = 2.0 / 3.0
    var presentedViewHeight: CGFloat = 2.0 / 3.0
    
    override var frameOfPresentedViewInContainerView: CGRect {
        guard let containerView = containerView else { return .zero }
        var frame: CGRect = .zero
        frame.size = size(forChildContentContainer: presentedViewController, withParentContainerSize: containerView.bounds.size)
        
        switch direction {
        case .right:
            frame.origin.x = containerView.frame.width * (1.0 / 3.0)
        case .bottom:
            frame.origin.y = containerView.frame.height * (1.0 / 3.0)
        default:
            frame.origin = .zero
        }
        return frame
    }
    
    // MARK: - Initializers
    init(presentedViewController: UIViewController,
         presenting presentingViewController: UIViewController?,
         direction: PresentationDirection) {
        self.direction = direction
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
    }
    
    override func presentationTransitionWillBegin() {
        guard let containerView = containerView else { return }
        containerView.insertSubview(dimmingView, at: 0)
        dimmingView.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
        dimmingView.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
        dimmingView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        dimmingView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        
        guard let coordinator = presentedViewController.transitionCoordinator else {
            dimmingView.alpha = 1.0
            return
        }
        
        coordinator.animate(alongsideTransition: { _ in
            self.dimmingView.alpha = 1.0
        })
    }
    
    override func dismissalTransitionWillBegin() {
        guard let coordinator = presentedViewController.transitionCoordinator else {
            dimmingView.alpha = 0.0
            return
        }
        
        coordinator.animate(alongsideTransition: { _ in
            self.dimmingView.alpha = 0.0
        })
    }
    
    override func containerViewWillLayoutSubviews() {
        presentedView?.frame = frameOfPresentedViewInContainerView
    }
    
    override func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
        switch direction {
        case .left, .right:
            return CGSize(width: parentSize.width * (2.0 / 3.0), height: parentSize.height)
        case .bottom, .top:
            return CGSize(width: parentSize.width, height: parentSize.height * (2.0 / 3.0))
        }
    }
    
    private lazy var dimmingView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(white: 0.0, alpha: 0.5)
        view.alpha = 0.0
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(handleDimmedViewTap(recognizer:)))
        view.addGestureRecognizer(recognizer)
        return view
    }()
    
    // MARK: - Action
    @objc private func handleDimmedViewTap(recognizer: UITapGestureRecognizer) {
        presentingViewController.dismiss(animated: true)
    }
}
