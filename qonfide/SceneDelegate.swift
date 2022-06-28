//
//  SceneDelegate.swift
//  qonfide
//
//  Created by Hansel Matthew on 10/06/22.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    let defaults = UserDefaults.standard

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        Task.init{
            let fetchedInput = try await ChatServiceClass.fetchMessages()
            AppHelper.appInputs = fetchedInput
        }
        
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        window?.makeKeyAndVisible()
        window?.rootViewController = UINavigationController(rootViewController: TabBarController())
        UINavigationBar.appearance().backIndicatorImage = UIImage(named: "backButton")
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = UIImage(named: "backButton")

//        if defaults.bool(forKey: "First Launch") {

////            open for second time or more

//            print("kedua")
//            defaults.set(true, forKey: "First Launch")
//            window = UIWindow(windowScene: scene)
//            window?.makeKeyAndVisible()
//            window?.rootViewController = UINavigationController(rootViewController: LoginPageController())

//        } else {
////          open for first time
//            print("pertama")
//            defaults.set(true, forKey: "First Launch")

////            let storyboard = UIStoryboard(name: "Onboard", bundle: nil)
//            let storyboard = UIStoryboard(name: "Home", bundle: nil)
////            let initiateVC = storyboard.instantiateViewController(withIdentifier: "OnboardView")
//            let initiateVC = storyboard.instantiateViewController(withIdentifier: "homeView")

//            let storyboard = UIStoryboard(name: "Onboard", bundle: nil)
//            let initiateVC = storyboard.instantiateViewController(withIdentifier: "OnboardView")

//            window = UIWindow(windowScene: scene)
//            window?.makeKeyAndVisible()
//            window?.rootViewController = UINavigationController(rootViewController: initiateVC)
//        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

