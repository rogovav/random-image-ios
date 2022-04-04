//
//  AppDelegate.swift
//  RandomImage
//
//  Created by Alexander Rogov on 03.04.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(
            _ application: UIApplication,
            didFinishLaunchingWithOptions options: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        let vc = setTabBar()
        window.rootViewController = vc
        window.makeKeyAndVisible()
        self.window = window
        return true
    }

    private func setTabBar() -> UITabBarController {
        let mainVC = UINavigationController(rootViewController: MainVC(MainVM()))
        mainVC.title = "Image"
        let bookmarksVC = UINavigationController(rootViewController: BookmarksVC(BookmarksVM()))
        bookmarksVC.title = "Bookmarks"
        let tabBarVC = UITabBarController()

        if let items = tabBarVC.tabBar.items {
            for index in 0..<items.count {
                items[index].image = UIImage(named: "home-icon")?.withRenderingMode(.alwaysOriginal)
                items[index].selectedImage = UIImage(named: "home-icon")?.withRenderingMode(.alwaysOriginal)
            }
        }

        tabBarVC.setViewControllers([mainVC, bookmarksVC], animated: false)
        tabBarVC.modalPresentationStyle = .fullScreen

        return tabBarVC
    }
}

