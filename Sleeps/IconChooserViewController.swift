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
    
    /// The icons to display in the chooser.
    let icons = [
        // Page 1, row 1
        R.image.calendar,
        R.image.clock,
        R.image.star,
        
        // Page 1, row 2
        R.image.heart,
        R.image.present,
        R.image.christmastree,
        
        // Page 1, row 3
        R.image.shoppingbag,
        R.image.sun,
        R.image.suitcase,
        
        // Page 2, row 1
        R.image.briefcase,
        R.image.university,
        R.image.house,
        
        // Page 2, row 2
        R.image.music,
        R.image.film,
        R.image.tv,
        
        // Page 2, row 3
        R.image.controller,
        R.image.cinema,
        R.image.ticket,
        
        // Page 3, row 1
        R.image.iphone,
        R.image.ipad,
        R.image.laptop,
        
        // Page 3, row 2
        R.image.desktop,
        R.image.headphones,
        R.image.coffee,
        
        // Page 3, row 3
        R.image.presentation,
        R.image.envelope,
        R.image.handbag,        
    ]
    
    /// The current page being displayed.
    var currentPage: Int = 0
    
    /// The total number of pages. There are 9 icons to a page, so the number of pages is the number
    /// of icons divided by 9.
    var pageCount: Int {
        let count = icons.count
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
        let visibleIcons = icons[firstIndex...finalIndex]
        
        pageContentView.icons = Array(visibleIcons)
        return pageContentView
    }
    
    
    
    
    
    // MARK: - View Controller

    override func viewDidLoad() {
        super.viewDidLoad()

        // Create the page view controller.
        guard let pageViewController = R.storyboard.main.iconPageViewController else { return }
        pageViewController.dataSource = self
        
        // Add the first page to the page view controller.
        guard let firstPage = viewControllerAtIndex(0) else { return }
        let viewControllers = [firstPage]
        pageViewController.setViewControllers(viewControllers, direction: .Forward, animated: false, completion: nil)
        
        // Set the size of the controller.
        pageViewController.view.frame = CGRectMake(0, 0, 320, 290)
        
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
        if currentPage == 0 {
            return nil
        }
        
        return viewControllerAtIndex(--currentPage)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        if currentPage == pageCount - 1 {
            return nil
        }
        
        return viewControllerAtIndex(++currentPage)
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return pageCount
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }

}
