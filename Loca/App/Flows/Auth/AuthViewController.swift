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
        authView.goButtonHandler = auth.self
    }
    
    // MARK: Actions
    
    private func auth(username: String?, password: String?) {
        guard let username = username,
            let password = password else { return }
        
        if username == AuthSample.login,
           password == AuthSample.password {
            print("Success!!! Now user is login")
            UserDefaults.standard.set(true, forKey: "isLogin")
            navigationController?.popViewController(animated: true)
        }
    }
    
    private func register() {
        
    }
    
    private func passwordRecovery() {
        navigationController?.pushViewController(PasswordRecoveryViewController(), animated: true)
    }
}
