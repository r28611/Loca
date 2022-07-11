//
//  AuthViewModel.swift
//  Loca
//
//  Created by Margarita Novokhatskaia on 11/07/2022.
//

import Foundation

protocol AuthViewModel {
    var alertTitle: String { get }
    func handleInputChanged(login: String, password: String)
    
    var submitButtonEnabled: Bool { get }
    var submitButtonEnabledChanged: ((Bool) -> ())? { get set }
}

class AuthViewModelImpl: AuthViewModel {
    
    private let model: AuthInputModel
    
    init(model: AuthInputModel) {
        self.model = model
    }
    
    var alertTitle: String {
        return "Please input correct login and password (min \(model.passwordLength) simbols)"
    }
    
    func handleInputChanged(login: String, password: String) {
        submitButtonEnabled = model.isInputValid(login: login, password: password)
    }
    
    var submitButtonEnabled: Bool = false {
        didSet {
            submitButtonEnabledChanged?(submitButtonEnabled)
        }
    }
    
    var submitButtonEnabledChanged: ((Bool) -> ())?
    
}
