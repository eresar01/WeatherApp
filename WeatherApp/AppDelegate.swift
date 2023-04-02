//
//  AppDelegate.swift
//  WeatherApp
//
//  Created by Yerem Sargsyan on 02.04.23.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Setup Navigation Bar Style
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.shadowColor = .clear
        appearance.titleTextAttributes = [.foregroundColor: AppColors.Text.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: AppColors.Text.white]
        appearance.backgroundColor = AppColors.Background.darkBlue
        
        let appearanceBar = UINavigationBar.appearance()
        appearanceBar.isTranslucent = true
        appearanceBar.prefersLargeTitles = true
        appearanceBar.shadowImage = UIImage()
        appearanceBar.tintColor = AppColors.Background.default
        appearanceBar.barTintColor = AppColors.Background.darkBlue
        appearanceBar.backgroundColor = AppColors.Background.darkBlue
        
        appearanceBar.standardAppearance = appearance
        appearanceBar.compactAppearance = appearance
        appearanceBar.scrollEdgeAppearance = appearance

        return true
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
            return .portrait
        case .pad:
            return .landscape
        default:
            return .portrait
        }
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

