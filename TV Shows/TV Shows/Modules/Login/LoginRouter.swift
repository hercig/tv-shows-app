//
//  LoginRouter.swift
//  TV Shows
//
//  Created by Filip Hercig on 08.06.2022..
//

import Foundation

protocol LoginRouting {
    func navigateToHomeViewController()
}

final class LoginRouter: LoginRouting {
    
    weak var viewController: LoginViewController?
    
    func navigateToHomeViewController() {
        let homeRouter = HomeRouter()
        let homeViewModel = HomeViewModel(router: homeRouter)
        let homeViewController = HomeViewController()
        viewController?.navigationController?.setViewControllers([homeViewController], animated: true)
    }
}
