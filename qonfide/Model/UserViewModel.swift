//
//  LoginViewModel.swift
//  qonfide
//
//  Created by Hansel Matthew on 13/06/22.
//

import Foundation

protocol LoginProtocol{
    var formIsValid: Bool {get}
}

struct LoginViewModel: LoginProtocol {
    var email: String?
    var password: String?

    var formIsValid: Bool{
        return email?.isEmpty == false && password?.isEmpty == false
    }
}

struct SignupViewModel: LoginProtocol {
    var email: String?
    var username: String?
    var password: String?
    var confirmedPassword: String?
    
    
    var formIsValid: Bool{
        return email?.isEmpty == false && username?.isEmpty == false && password?.isEmpty == false && confirmedPassword?.isEmpty == false
    }
    
    var passwordIsValid: Bool{
        return password == confirmedPassword
    }
    
}
