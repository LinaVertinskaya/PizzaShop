//
//  PizzaShopApp.swift
//  PizzaShop
//
//  Created by Лина Вертинская on 21.08.22.
//

import SwiftUI
import Firebase
import FirebaseAuth

let screen = UIScreen.main.bounds

@main
struct PizzaShopApp: App {

    @UIApplicationDelegateAdaptor private var appDelegate: AppDelegate

    var body: some Scene {
        WindowGroup {
            if let user = AuthService.shared.currentUser {
                if user.uid == "mtCvZLkUEIaM7P3QszAuPq3u2UF2" {
                    AdminOrdersView()
                } else {
                    let viewModel = MainTabBarViewModel(user: user)
                    MainTabBar(viewModel: viewModel)
                }
            } else {
                AuthView()
            }
        }
    }

    class AppDelegate: NSObject, UIApplicationDelegate {

        func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {

            FirebaseApp.configure()
            print("App Delegate")
            
            return true
        }
    }
}
