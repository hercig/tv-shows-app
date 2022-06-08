//
//  LoginViewModel.swift
//  TV Shows
//
//  Created by Filip Hercig on 08.06.2022..
//

import Foundation

protocol LoginViewModeling {
    func handleLoginButtonTap(username: String?, password: String?)
    func handleRegisterButtonTap(username: String?, password: String?)
}

final class LoginViewModel {
    
    private let userService: UserServicing
    private let router: LoginRouting
    
    init(router: LoginRouter, userService: UserService = UserService()) {
        self.router = router
        self.userService = userService
    }
}

extension LoginViewModel: LoginViewModeling {
    
    func handleLoginButtonTap(username: String?, password: String?) {
        guard !username.isEmptyOrNil, !password.isEmptyOrNil else { return }
        print("Tap with \(username) and \(password)") // TODO: Handle empty field
    }
    
    func handleRegisterButtonTap(username: String?, password: String?) {
        
    }
}
