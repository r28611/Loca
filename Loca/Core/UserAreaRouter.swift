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
            
            let viewController = AuthViewController()
            viewController.viewModel = AuthViewModelImpl(model: AuthInputModelImpl())
            controller?.navigationController?.pushViewController(viewController, animated: true)
        
        } else {
            
            controller?.navigationController?.pushViewController(UserAreaViewController(), animated: true)
        
        }
    }
    
}
