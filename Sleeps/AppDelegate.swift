//
//  AppDelegate.swift
//  Sleeps
//
//  Created by Josh Asch on 30/03/2015.
//  Copyright (c) 2015 Bearhat. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    /// Application window.
    var window: UIWindow?
    
    /// Persistence Controller for managing the Core Data stack.
    var persistenceController: PersistenceController?
    
    /// The root view controller.
    var tableViewController: CountdownTableViewController?
    
    
    // MARK: - Activation
    
    /// Called when the application first launches.
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {        
        // Create a persistence controller, giving it our callback function.
        self.persistenceController = PersistenceController(callback: persistenceControllerDidInitialise)
        
        // Pass the persistence controller into the root view controller.
        let navigationController = window?.rootViewController as! UINavigationController
        tableViewController = navigationController.viewControllers[0] as? CountdownTableViewController
        tableViewController?.persistenceController = self.persistenceController
        
        // Fill the background colour of the navigation bar and toolbar if enabled.
        if (kNavigationBarFilled) {
            navigationController.navigationBar.barTintColor = kNavigationControllerBarColour
        }
        if (kToolbarFilled) {
            navigationController.toolbar.barTintColor = kToolbarColour
        }
        
        // Set the background of the navigation controller to get rid of the dark flashes on segues.
        navigationController.view.backgroundColor = UIColor.whiteColor()
        
        // Set the global tint colour.
        window?.tintColor = kGlobalTintColour
        
        // Tint the navigation bar.
        navigationController.navigationBar.tintColor = kNavigationControllerTintColour
        navigationController.toolbar.tintColor = kNavigationControllerTintColour
        
        return true
    }
    
    /// Called when the application is about to return from the background.
    func applicationWillEnterForeground(application: UIApplication) {
        if let tableViewController = tableViewController {
            tableViewController.reloadData()
            tableViewController.updatePastCountdowns()
        }
    }
    
    /// Called when the application has resumed from being inactive.
    func applicationDidBecomeActive(application: UIApplication) {
        if let tableViewController = tableViewController {
            tableViewController.refreshViewAtMidnight()
        }
    }

    
    
    // MARK: - Deactivation and termination

    /// Notification sent when the application is about to move from active to inactive state. This
    /// can occur for certain types of temporary interruptions (such as an incoming phone call or
    /// SMS message) or when the user quits the application and it begins the transition to the
    /// background state.
    /// This function pauses ongoing tasks and saves any object model changes to disk.
    func applicationWillResignActive(application: UIApplication) {
        persistenceController?.save()
        
        // Cancel the timer which is set to fire at midnight, because if the app is not open, there
        // is no point refreshing the data.
        if let tableViewController = tableViewController {
            tableViewController.cancelTimer()
        }
    }

    /// Saves object model changes to disk and stores application state information in order to
    /// restore the application to its current state in case it gets terminated later.
    func applicationDidEnterBackground(application: UIApplication) {
        persistenceController?.save()
    }
    
    /// Called when the application is about to terminate. Saves any changes to the object model.
    func applicationWillTerminate(application: UIApplication) {
        persistenceController?.save()
        
        // Cancel the timer which is set to fire at midnight, because if the app is not open, there
        // is no point refreshing the data.
        if let tableViewController = tableViewController {
            tableViewController.cancelTimer()
        }
    }

    
    
    // MARK: - SLPersistenceController
    
    /// Callback which is called when the persistence controller finishes intialising the Core Data
    /// stack.
    func persistenceControllerDidInitialise(success: Bool) {
        if !success {
            print("Persistence controller failed to initialise. What now...?")
            return
        }
        
        // If this is the first launch of the app, add the default countdowns.
        let defaults = NSUserDefaults.standardUserDefaults()
        let key = "previouslyLaunched"
        if !defaults.boolForKey(key) {
            Countdown.createDefaultCountdownsUsingPersistenceController(self.persistenceController!)
            defaults.setBool(true, forKey: key)
        }
        
        // Tell the root view controller to reload its data.
        dispatch_async(dispatch_get_main_queue()) {
            if let tableViewController = self.tableViewController {
                tableViewController.reloadData()
                tableViewController.updatePastCountdowns()
            }
        }
    }
}

