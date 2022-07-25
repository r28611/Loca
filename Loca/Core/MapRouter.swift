//
//  MapRouter.swift
//  Loca
//
//  Created by Margarita Novokhatskaia on 23/07/2022.
//

import UIKit

class MapRouter: NSObject, Router {
    
    weak var controller: UIViewController?
    
    init(viewController: UIViewController) {
            self.controller = viewController
    }
    
    func navigateToUserArea() {
        if !UserDefaults.standard.bool(forKey: "isLogin") {
            
            let viewController = AuthViewController()
            viewController.viewModel = AuthViewModelImpl(model: AuthInputModelImpl())
            controller?.navigationController?.pushViewController(viewController, animated: true)
        
        } else {
            
            controller?.navigationController?.pushViewController(UserAreaViewController(), animated: true)
        
        }
    }
    
    func makeAlert(complitionFirstAction: (() -> Void)? = nil,
                   complitionSecondAction: (() -> Void)? = nil) -> UIAlertController {
        
        let alertController = UIAlertController(title: Text.startNewTrack,
                                                message: Text.startNewTrackDescription,
                                                preferredStyle: .alert)
        let createButton = UIAlertAction(title: Text.saveAndStart, style: .default) { _ in
            complitionFirstAction?()
        }
        
        let cancelButton = UIAlertAction(title: Text.startWithoutSaving, style: .destructive) { _ in
            complitionSecondAction?()
        }
        
        alertController.addAction(createButton)
        alertController.addAction(cancelButton)
        
        return alertController
    }
    
}
