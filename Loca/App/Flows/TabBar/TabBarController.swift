//
//  TabBarController.swift
//  Loca
//
//  Created by Margarita Novokhatskaia on 24/07/2022.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCustomTabBar()
        
        setupViewControllers()
        
        selectedIndex = 1
    }
    
    private func setupViewControllers() {
        
        // Routes list button
        let tabOne = RoutesListController()
        let tabOneBarItem = UITabBarItem(title: "Routes", image: UIImage(systemName: "location.circle"), tag: 1)
        tabOne.tabBarItem = tabOneBarItem
        
        // Start/stop button
        let tabTwo = MapViewController()
        let tabTwoBarItem = UITabBarItem(title: nil, image: nil, tag: 2)
        tabTwo.tabBarItem = tabTwoBarItem
        
        // user area
        let tabThree = UserAreaViewController()
        let tabThreeBarItem = UITabBarItem(title: "You", image: UIImage(systemName: "person.circle"), tag: 3)
        tabThree.tabBarItem = tabThreeBarItem
        
        viewControllers = [tabOne, tabTwo, tabThree]
    }
    
    private func setupCustomTabBar() {
        setValue(CustomTabBar(frame: tabBar.frame), forKey: "tabBar")
        
        if let customTabBar = tabBar as? CustomTabBar {
            customTabBar.middleButtonHandler = { [ weak self ] in
                self?.selectedIndex = 1
            }
            customTabBar.doubleTapHandler = { [ weak self ] in
                if let map = self?.viewControllers?[1] as? MapViewController {
                    map.startTrackDidTapped()
                }
            }
        }
    }

}
