//
//  AppDelegate.swift
//  Example
//  Copyright (c) 2015年 terut. All rights reserved.
//

import UIKit
import Wayfaring

enum AppResource: Resource {
    case First, Second

    // MARK: - Resource
    static var all: [Resource] {
        return [First, Second]
    }

    // MARK: - Resource
    var path: String {
        switch self {
        case .First:
            return "/first"
        case .Second:
            return "/second/:second_id"
        default:
            return ""
        }
    }

    var identifier: String {
        switch self {
        case .First:
            return "firstView"
        case .Second:
            return "secondView"
        }
    }
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        Routes.sharedInstance.bootstrap(AppResource.all)

        let navController = self.window?.rootViewController as! UINavigationController
        //let targetURL = "com.example://first"
        let targetURL = "com.example://second/secsec"
        //let targetURL = "com.example://third/check"
        (navController.topViewController as! ViewController).targetURL = targetURL
        return true
    }

    func application(application: UIApplication, willFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

