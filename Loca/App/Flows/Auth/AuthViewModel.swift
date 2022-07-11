//
//  AuthViewModel.swift
//  Loca
//
//  Created by Margarita Novokhatskaia on 11/07/2022.
//

import Foundation
import RxSwift

protocol AuthViewModel {
    var alertTitle: String { get }
    func handleInputChanged(login: String?, password: String?)
    
    var submitButtonEnabled: BehaviorSubject<Bool> { get }
}

class AuthViewModelImpl: AuthViewModel {
    
    private let model: AuthInputModel
    
    init(model: AuthInputModel) {
        self.model = model
    }
    
    var alertTitle: String {
        return "Please input correct login and password (min \(model.passwordLength) simbols)"
    }
    
    func handleInputChanged(login: String?, password: String?) {
        guard let login = login,
              let password = password else { return }
        
        submitButtonEnabled.onNext(model.isInputValid(login: login, password: password))
    }
    
    var submitButtonEnabled: BehaviorSubject<Bool> = BehaviorSubject(value: false)
    
}
