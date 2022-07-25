//
//  TabBarController.swift
//  Loca
//
//  Created by Margarita Novokhatskaia on 24/07/2022.
//

import UIKit

class TabBarController: UITabBarController {
    
    private let middleButtonDiameter: CGFloat = 42

    private lazy var middleButton: UIButton = {
        let middleButton = UIButton()
        middleButton.layer.cornerRadius = middleButtonDiameter / 2
        middleButton.backgroundColor = .white
        middleButton.translatesAutoresizingMaskIntoConstraints = false
        middleButton.addTarget(self, action: #selector(didPressMiddleButton), for: .touchUpInside)
        return middleButton
    }()
    
    private lazy var heartImageView: UIImageView = {
        let heartImageView = UIImageView()
        heartImageView.image = UIImage(systemName: "record.circle")
        heartImageView.tintColor = UIColor(red: 254.0 / 255.0, green: 116.0 / 255.0, blue: 96.0 / 255.0, alpha: 1.0)
        heartImageView.translatesAutoresizingMaskIntoConstraints = false
        return heartImageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setValue(CustomTabBar(frame: tabBar.frame), forKey: "tabBar")
        makeUI()
        
        // Get route button
        let tabOne = UserAreaViewController()
        let tabOneBarItem = UITabBarItem(title: "Get route", image: UIImage(systemName: "location.circle"), tag: 1)
        tabOne.tabBarItem = tabOneBarItem

        // Start/stop button
        let tabTwo = MapViewController()
        let tabTwoBarItem = UITabBarItem(title: nil, image: nil, tag: 2)
        tabTwo.tabBarItem = tabTwoBarItem

        // user area
        let tabThree = UserAreaViewController()
        let tabThreeBarItem = UITabBarItem(title: "User area", image: UIImage(systemName: "person.circle"), tag: 3)
        tabThree.tabBarItem = tabThreeBarItem

        viewControllers = [tabOne, tabTwo, tabThree]
        selectedIndex = 1
    }
    
    private func makeUI() {
        // 1
        tabBar.addSubview(middleButton)
        middleButton.addSubview(heartImageView)
        
        // 2
        NSLayoutConstraint.activate([
            // 2.1
            middleButton.heightAnchor.constraint(equalToConstant: middleButtonDiameter),
            middleButton.widthAnchor.constraint(equalToConstant: middleButtonDiameter),
            // 2.2
            middleButton.centerXAnchor.constraint(equalTo: tabBar.centerXAnchor),
            middleButton.topAnchor.constraint(equalTo: tabBar.topAnchor, constant: -10)
        ])
        
        // 3
        NSLayoutConstraint.activate([
            // 3.1
            heartImageView.heightAnchor.constraint(equalToConstant: 26),
            heartImageView.widthAnchor.constraint(equalToConstant: 26),
            // 3.2
            heartImageView.centerXAnchor.constraint(equalTo: middleButton.centerXAnchor),
            heartImageView.centerYAnchor.constraint(equalTo: middleButton.centerYAnchor)
        ])
    }
    
    @objc private func didPressMiddleButton() {
        selectedIndex = 1
        middleButton.backgroundColor = .green
    }

}

// MARK: - UITabBarControllerDelegate

extension TabBarController: UITabBarControllerDelegate {
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        let selectedIndex = self.tabBar.items?.firstIndex(of: item)
        if selectedIndex == 1 {
            middleButton.backgroundColor = .green
        } else {
            middleButton.backgroundColor = .red
        }
    }
}
