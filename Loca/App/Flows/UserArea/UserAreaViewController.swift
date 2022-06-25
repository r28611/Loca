//
//  UserAreaViewController.swift
//  Loca
//
//  Created by Margarita Novokhatskaia on 25/06/2022.
//

import UIKit

class UserAreaViewController: UITableViewController {
    
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
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = UserAreaCell(.editProfile)
            return cell
        case 1:
            let cell = UserAreaCell(.notification)
            return cell
        case 2:
            let cell = UserAreaCell(.logout)
            return cell
        default:
            return UITableViewCell()
        }
    }
}

