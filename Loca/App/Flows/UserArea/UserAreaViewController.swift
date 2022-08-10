//
//  UserAreaViewController.swift
//  Loca
//
//  Created by Margarita Novokhatskaia on 25/06/2022.
//

import UIKit

class UserAreaViewController: UIViewController {
    
    let settings = UserSettingsTableViewController()
    
    // MARK: - Controller lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGroupedBackground
        add(childViewController: settings, to: view)
        setConstraints()
    }
    
    private func setConstraints() {
        
        let compareParentConstraints = [
            view.leadingAnchor.constraint(equalTo: settings.view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: settings.view.trailingAnchor),
            view.topAnchor.constraint(equalTo: settings.view.topAnchor, constant: 120),
            view.bottomAnchor.constraint(equalTo: settings.view.bottomAnchor)
            
            settings.view.leadingAnchor.constraint(equalTo: view.leadingAnchor.constraint),
            view.trailingAnchor.constraint(equalTo: settings.view.trailingAnchor),
            view.topAnchor.constraint(equalTo: settings.view.topAnchor, constant: 120),
            view.bottomAnchor.constraint(equalTo: settings.view.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(compareParentConstraints)
    }
  
}
