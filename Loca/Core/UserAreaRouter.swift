//
//  UserAreaRouter.swift
//  Loca
//
//  Created by Margarita Novokhatskaia on 28/06/2022.
//

import UIKit

class UserAreaRouter: NSObject, Router {
    
    weak var controller: UIViewController?
    
    init(viewController: UIViewController) {
            self.controller = viewController
    }
    
    func navigateToController() {
        if !UserDefaults.standard.bool(forKey: "isLogin") {
            
            controller?.navigationController?.pushViewController(AuthViewController(), animated: true)
        
        } else {
            
            controller?.navigationController?.pushViewController(UserAreaViewController(), animated: true)
        
        }
    }
    
}
