//
//  CardViewTransitionManager.swift
//  Sleeps
//
//  Created by Josh Asch on 03/06/2015.
//  Copyright (c) 2015 Bearhat. All rights reserved.
//

import UIKit

class CardViewTransitionManager: NSObject, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate {
    
    /// Whether the transition is presenting a screen, or dismissing a screen.
    var presenting = true
    
    
   
    // MARK: - UIViewControllerAnimatedTransitioning
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning)
    {
        // TODO: Perform an animation.
    }
    
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval
    {
        return 0.5
    }
    
    
    
    // MARK: UIViewControllerTransitioningDelegate
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning?
    {
        return self
    }
    
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning?
    {
        return self
    }
    
}
