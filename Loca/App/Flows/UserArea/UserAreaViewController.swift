//
//  UserAreaViewController.swift
//  Loca
//
//  Created by Margarita Novokhatskaia on 25/06/2022.
//

import UIKit

class UserAreaViewController: UITableViewController {
    
    private let userAreaSettingsRows: [Int: UserAreaSettings] = [
        0: .editProfile,
        1: .notification,
        2: .logout
    ]
    
    // MARK: - Initialization
    
    init() {
        if #available(iOS 13.0, *) {
            super.init(style: .insetGrouped)
        } else {
            super.init(nibName: nil, bundle: nil)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Controller lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = .systemGroupedBackground

    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Settings"
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let settingType = userAreaSettingsRows[indexPath.row]
            else { return UITableViewCell() }
        
        return UserAreaCell(settingType)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if userAreaSettingsRows[indexPath.row] == .logout {
            
            UserDefaults.standard.set(false, forKey: "isLogin")
            
            self.navigationController?.popViewController(animated: true)
            
        }
        
    }
}

