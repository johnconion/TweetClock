//
//  AppDelegate.swift
//  TweetClock
//
//  Created by Ryosuke Tamura on 2020/04/25.
//  Copyright © 2020 Ryosuke Tamura. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import Swifter

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    private let TWITTER_CONSUMER_KEY = "eUKL99KPRxcg2zdeiU9BjSN7s"
    private let TWITTER_CONSUMER_SECRET = "PqxWwKTaOpsMLVA1g3iZ8G92RWsohgieOW49SywSS4Qwpb3Yw3"

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        IQKeyboardManager.shared.enable = true
        SwifterWrapper.share.setup(consumerKey: TWITTER_CONSUMER_KEY, consumerSecret: TWITTER_CONSUMER_SECRET)
        return true
    }
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

