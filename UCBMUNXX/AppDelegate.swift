//
//  AppDelegate.swift
//  UCBMUNXX
//
//  Created by Steven Chen on 12/24/15.
//  Copyright © 2015 Steven Chen. All rights reserved.
//

import UIKit
import UserNotifications
import Stripe

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        Parse.enableLocalDatastore()
        let configuration = ParseClientConfiguration {
            $0.applicationId = "DRJyulyY1xIvNoMK50VkXbepJvtu0dGtgFRS28BJ"
            $0.clientKey = "lmfigEERQYW01s8Oxbz72qxVMgQHiabxrNZ09Ae7"
            $0.server = "https://thawing-castle-82553.herokuapp.com/parse"
        }
        // Swift 3.0
        Parse.initialize(with: configuration)
        
        MUNChatPost.registerSubclass()
        NewsPost.registerSubclass()
        MUNChatReply.registerSubclass()
        MerchOrder.registerSubclass()
        
        // [Optional] Power your app with Local Datastore. For more info, go to
        // https://parse.com/docs/ios/guide#local-datastore
        
        // Initialize Parse.
//        Parse.setApplicationId("DRJyulyY1xIvNoMK50VkXbepJvtu0dGtgFRS28BJ",
//            clientKey: "lmfigEERQYW01s8Oxbz72qxVMgQHiabxrNZ09Ae7")
//        
        // [Optional] Track statistics around application opens.
        PFAnalytics.trackAppOpened(launchOptions: launchOptions)
        
        if #available(iOS 10.0, *) {
            let center = UNUserNotificationCenter.current()
            center.requestAuthorization(options:[.badge, .alert, .sound]) { (granted, error) in
                // Enable or disable features based on authorization.
            }
            
        } else {
//            let types: UIUserNotificationType = [.alert, .badge, .sound]
//            let settings = UIUserNotificationSettings(forTypes: types, categories: nil)
//            application.registerUserNotificationSettings(settings)
            // Fallback on earlier versions
        }
        
        application.registerForRemoteNotifications()
        
        if let notification = launchOptions?[UIApplicationLaunchOptionsKey.remoteNotification] as? [String: AnyObject] {
            print(notification)
            handleNotification(userInfo: notification)
        }
        
        // STRIPE STUFF
        // STPPaymentConfiguration.shared().publishableKey = "pk_live_PHPQ7qswKP58hpHC1YfEOSsa"
        
        UITabBar.appearance().tintColor = UIColor(red: 0.204, green:0.286, blue:0.369, alpha:1)
        
        UINavigationBar.appearance().barStyle = UIBarStyle.black
        UINavigationBar.appearance().tintColor = UIColor.white
        
        // Override point for customization after application launch.
        return true
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let installation = PFInstallation.current()
        installation?.setDeviceTokenFrom(deviceToken as Data)
        print(deviceToken)
        installation?.saveInBackground()
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        if error._code == 3010 {
            print("Push notifications are not supported in the iOS Simulator.")
        } else {
            print("application:didFailToRegisterForRemoteNotificationsWithError: %@", error)
        }
    }
    
//    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
//        PFPush.handle(userInfo)
//        
//        
//    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        PFPush.handle(userInfo)
        handleNotification(userInfo: userInfo)
//        let aps = userInfo["aps"] as? [String:Any]
//        print(userInfo)
//        let pushType = userInfo["type"] as? String
//        print(pushType as Any)
//        if pushType == "programming" {
//            NotificationCenter.default.post(name: Notification.Name("TEST"), object: nil)
//            print("Notification received")
//
//        }
        
    }
    
    func handleNotification(userInfo: [AnyHashable : Any]) {
        let aps = userInfo["aps"] as? [String:Any]
        print(userInfo)
        let pushType = userInfo["type"] as! String
        print(pushType as Any)
        switch pushType {
            case "programming":
                NotificationCenter.default.post(name: Notification.Name("ProgrammingNotification"), object: nil)
                print("Notification received")
            case "merchandise":
                NotificationCenter.default.post(name: Notification.Name("MerchNotif"), object: nil)
            case "munchat":
                NotificationCenter.default.post(name: Notification.Name("ChatNotif"), object: nil)
            case "home":
                NotificationCenter.default.post(name: Notification.Name("HomeNotif"), object: nil)
            
        default:
            print("No type")
            
        }
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

