//
//  AuthViewController.swift
//  Loca
//
//  Created by Margarita Novokhatskaia on 15/06/2022.
//

import UIKit

class AuthViewController: UIViewController {
    //нашла с помощью Leaks, что у меня при переходе на этот контроллер каждый раз он создается заново, а старый остается в памяти
    private let authView = AuthView()
    var viewModel: AuthViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        authView.passwordRecoveryButtonHandler = { [weak self] in
            self?.passwordRecovery()
        }
        
        authView.goButtonHandler = { [weak self] (username, password) in
            self?.auth(username: username, password: password)
        }
        
        authView.textFieldsDidChangedHandler = { [weak self] (username, password) in
            self?.handleInputChanged(username: username, password: password)
        }
        
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
    
    private func passwordRecovery() {
        navigationController?.pushViewController(PasswordRecoveryViewController(), animated: true)
    }
}
