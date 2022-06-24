//
//  AuthViewController.swift
//  Loca
//
//  Created by Margarita Novokhatskaia on 15/06/2022.
//

import UIKit

class AuthViewController: UIViewController {

    private let authView = AuthView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view = authView
        authView.passwordRecoveryButtonHandler = passwordRecovery.self
    }
    
    // MARK: Actions
    
    @objc private func authButtonTapped() {
//        navigationController?.pushViewController(SigninViewController(), animated: true)
    }
    
    @objc private func registerButtonTapped() {
//        navigationController?.pushViewController(RegisterViewController(), animated: true)
    }
    
    private func passwordRecovery() {
        navigationController?.pushViewController(PasswordRecoveryViewController(), animated: true)
    }
}
