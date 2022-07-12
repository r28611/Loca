//
//  AuthViewModel.swift
//  Loca
//
//  Created by Margarita Novokhatskaia on 11/07/2022.
//

import Foundation
import Bond

protocol AuthViewModel {
    var submitButtonEnabled: Observable<Bool> { get }
    var alertTitle: String { get }
    
    func handleInputChanged(login: String?, password: String?)
}

class AuthViewModelImpl: AuthViewModel {
    
    private let model: AuthInputModel
    
    init(model: AuthInputModel) {
        self.model = model
    }
    
    var submitButtonEnabled: Observable<Bool> = Observable<Bool>(false)
    
    var alertTitle: String {
        return "Please input correct login and password (min \(model.passwordLength) simbols)"
    }
    
    func handleInputChanged(login: String?, password: String?) {
        guard let login = login,
              let password = password else { return }
        submitButtonEnabled.value = model.isInputValid(login: login, password: password)
    }
    
}
