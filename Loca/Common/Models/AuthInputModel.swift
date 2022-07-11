//
//  AuthInputModel.swift
//  Loca
//
//  Created by Margarita Novokhatskaia on 11/07/2022.
//

import Foundation

protocol AuthInputModel {
    func isInputValid(login: String, password: String) -> Bool
    var passwordLength: Int { get }
}

class AuthInputModelImpl: AuthInputModel {
    
    func isInputValid(login: String, password: String) -> Bool {
        return password.count == passwordLength && !login.contains(" ")
    }
    
    var passwordLength: Int {
        return 6
    }
    
}
