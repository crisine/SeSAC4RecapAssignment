//
//  TabBarViewController.swift
//  SeSAC4RecapAssignment
//
//  Created by Minho on 1/21/24.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        configureViewControllers()
    }

    
    func configureViewControllers() {
        self.tabBar.unselectedItemTintColor = .darkGray
        self.tabBar.tintColor = .pointColor
        
        if let magnifyingGlassImage = UIImage(systemName: "magnifyingglass") {
            let tabBarItem = UITabBarItem(title: "검색", image: magnifyingGlassImage, tag: 0)

            self.viewControllers?[0].tabBarItem = tabBarItem
        }
        
        if let personImage = UIImage(systemName: "person") {
            let tabBarItem = UITabBarItem(title: "설정", image: personImage, tag: 1)

            self.viewControllers?[1].tabBarItem = tabBarItem
        }
    }

}
