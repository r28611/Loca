//
//  AuthViewController.swift
//  Loca
//
//  Created by Margarita Novokhatskaia on 15/06/2022.
//

import UIKit

class AuthViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view = AuthView()
    }
    
    // MARK: Actions
    
    @objc private func authButtonTapped() {
//        navigationController?.pushViewController(SigninViewController(), animated: true)
    }
    
    @objc private func registerButtonTapped() {
//        navigationController?.pushViewController(RegisterViewController(), animated: true)
    }
}
