//
//  AppColors.swift
//  Loca
//
//  Created by Margarita Novokhatskaia on 25/07/2022.
//

import UIKit

// TUTORIAL:
//   Colors for App
// USAGE:
//   let color: UIColor = AppColors.white
//   let color = AppColors.white

enum AppColors {
    
    // bad color will be set for colors missed in Colors.xcassets
    static let badColor = UIColor.yellow
    
    // Commom colors section
    static let pink = UIColor(named: "pink") ?? badColor
    static let cian = UIColor(named: "cian") ?? badColor
    static let background = UIColor(named: "background") ?? badColor
    static let lightGray = UIColor(named: "lightGray") ?? badColor
}
