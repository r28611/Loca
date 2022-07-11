//
//  AuthViewController.swift
//  Loca
//
//  Created by Margarita Novokhatskaia on 15/06/2022.
//

import UIKit

class AuthViewController: UIViewController {

    private let authView = AuthView()
    var viewModel: AuthViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        authView.passwordRecoveryButtonHandler = passwordRecovery.self
        authView.goButtonHandler = auth.self
        
        authView.textFieldsDidChangedHandler = handleInputChanged.self
        
        viewModel?.submitButtonEnabledChanged = { [unowned self] (enabled) in
            self.authView.goButton.isEnabled = enabled
        }
    }
    
    private func setupView() {
        view.backgroundColor = .white
        view = authView
        authView.goButton.isEnabled = viewModel?.submitButtonEnabled ?? false
    }
    
    // MARK: Actions
    
    private func handleInputChanged(username: String?, password: String?) {
        viewModel?.handleInputChanged(login: username, password: password)
    }
    
    private func auth(username: String?, password: String?) {
        guard let username = username,
            let password = password else { return }
        
        if username == AuthSample.login,
           password == AuthSample.password {
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
