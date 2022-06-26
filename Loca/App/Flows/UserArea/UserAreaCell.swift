//
//  UserAreaCell.swift
//  Loca
//
//  Created by Margarita Novokhatskaia on 25/06/2022.
//

import UIKit

class UserAreaCell: UITableViewCell {
    
    private var userAreaCells: [UserAreaSettings: String] = [
        .editProfile: Text.editProfile,
        .notification: Text.notification,
        .logout: Text.logout
    ]
    
    private let cellLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let notificationSwitch: UISwitch = {
        let switcher = UISwitch()
        switcher.isUserInteractionEnabled = true
        switcher.translatesAutoresizingMaskIntoConstraints = false
        return switcher
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(cellLabel)
        
        let margins = contentView.layoutMarginsGuide
        NSLayoutConstraint.activate([
            cellLabel.centerYAnchor.constraint(equalTo: margins.centerYAnchor),
            cellLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor)
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(_ userAreaSetting: UserAreaSettings) {
        self.init()
        
        cellLabel.text = userAreaCells[userAreaSetting]
        
        switch userAreaSetting {
        case .editProfile:
            accessoryType = .disclosureIndicator
        case .notification:
            selectionStyle = .none
            setupSwitcher()
        case .logout:
            accessoryType = .none
        }
    }
    
    private func setupSwitcher() {
        
        contentView.addSubview(notificationSwitch)
        
        NSLayoutConstraint.activate([
            notificationSwitch.centerYAnchor.constraint(equalTo: cellLabel.centerYAnchor),
            notificationSwitch.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24)
        ])
    }

}
