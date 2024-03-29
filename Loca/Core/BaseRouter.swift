//
//  BaseRouter.swift
//  Loca
//
//  Created by Margarita Novokhatskaia on 26/06/2022.
//

import UIKit

protocol Router: NSObject {
    func navigateToUserArea()
    func makeAlert(complitionFirstAction: (() -> Void)?,
                   complitionSecondAction: (() -> Void)?) -> UIAlertController
}
