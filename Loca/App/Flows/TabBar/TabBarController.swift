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
        
        // Get route button
        let tabOne = UserAreaViewController()
        let tabOneBarItem = UITabBarItem(title: "Get route", image: UIImage(systemName: "location.circle"), tag: 1)
        tabOne.tabBarItem = tabOneBarItem
        
        // Start/stop button
        let tabTwo = MapViewController()
        let tabTwoBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "record.circle"), tag: 2)
        tabTwo.tabBarItem = tabTwoBarItem
        
        // Start/stop button
        let tabThree = UserAreaViewController()
        let tabThreeBarItem = UITabBarItem(title: "User area", image: UIImage(systemName: "person.circle"), tag: 3)
        tabThree.tabBarItem = tabThreeBarItem
        
        self.viewControllers = [tabOne, tabTwo, tabThree]
    }

}
