//
//  TabBarController.swift
//  CTAProject
//
//  Created by Tomoya Tanaka on 2022/01/12.
//

import UIKit

final class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureViewControllers()
        configureAppearance()
    }
    
    private func configureViewControllers() {
        var viewControllers: [UIViewController] = []
        let searchShopsVC = SearchShopsViewController()
        let searchShopsVCWithNavigationController = NavigationController(rootViewController: searchShopsVC)
        searchShopsVC.tabBarItem = UITabBarItem(
            title: "リスト",
            image: UIImage(systemName: "list.bullet"),
            tag: 0
        )
        viewControllers.append(searchShopsVCWithNavigationController)
        setViewControllers(viewControllers, animated: false)
    }
    
    private func configureAppearance() {
        let appearance = UITabBarAppearance()
        appearance.backgroundColor = .white
        appearance.stackedLayoutAppearance.selected.iconColor = .systemYellow
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.systemYellow]
        UITabBar.appearance().standardAppearance = appearance
    }
    
}
