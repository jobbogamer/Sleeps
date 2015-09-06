//
//  IconChooserViewController.swift
//  Sleeps
//
//  Created by Josh Asch on 30/08/2015.
//  Copyright © 2015 Bearhat. All rights reserved.
//

import UIKit

class IconChooserViewController: UIViewController, UIPageViewControllerDataSource {
    
    /// The view controller which presented the popover.
    var presentingView: UIViewController!
    
    /// The total number of pages. There are 9 icons to a page, so the number of pages is the number
    /// of icons divided by 9.
    var pageCount: Int {
        let count = Countdown.icons.count
        if count % 9 == 0 {
            return count / 9
        }
        else {
            return (count / 9) + 1
        }
    }
    
    
    
    
    // MARK: - Functions
    
    func viewControllerAtIndex(index: Int) -> UIViewController? {
        guard let pageContentView = R.storyboard.main.iconPageViewContent else { return nil }
        
        let firstIndex = index * 9
        let finalIndex = firstIndex + 8
        let visibleIcons = Countdown.icons[firstIndex...finalIndex]
        
        pageContentView.icons = Array(visibleIcons)
        pageContentView.pageIndex = index
        return pageContentView
    }
    
    
    
    
    
    // MARK: - View Controller

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the popover background colour to match the background colour of the view inside.
        popoverPresentationController?.backgroundColor = self.view.backgroundColor

        // Create the page view controller.
        guard let pageViewController = R.storyboard.main.iconPageViewController else { return }
        pageViewController.dataSource = self
        
        // Add the first page to the page view controller.
        guard let firstPage = viewControllerAtIndex(0) else { return }
        let viewControllers = [firstPage]
        pageViewController.setViewControllers(viewControllers, direction: .Forward, animated: false, completion: nil)
        
        // Set the size of the controller.
        pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)
        
        // Set the colours of the page controller dots.
        let pageControl = UIPageControl.appearance()
        pageControl.pageIndicatorTintColor = kGlobalTintColour.colorWithAlphaComponent(0.3)
        pageControl.currentPageIndicatorTintColor = kGlobalTintColour
        
        // Display the page view controller.
        addChildViewController(pageViewController)
        view.addSubview(pageViewController.view)
        pageViewController.didMoveToParentViewController(self)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    // MARK: - UIPageViewControllerDataSource
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        // Get the current page number by accessing it from the view controller.
        guard let currentViewController = viewController as? IconPageViewController else { return nil }
        let currentPage = currentViewController.pageIndex
        
        // There's no page before page 0.
        if currentPage == 0 {
            return nil
        }
        
        // Get the view controller for the index before the current one.
        return viewControllerAtIndex(currentPage - 1)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        // Get the current page number by accessing it from the view controller.
        guard let currentViewController = viewController as? IconPageViewController else { return nil }
        let currentPage = currentViewController.pageIndex
        
        // There's no page after the last page.
        if currentPage == pageCount - 1 {
            return nil
        }
        
        // Get the view controller for the index after the current one.
        return viewControllerAtIndex(currentPage + 1)
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return pageCount
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }

}
