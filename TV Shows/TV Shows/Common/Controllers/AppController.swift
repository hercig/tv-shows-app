//
//  AppController.swift
//  TV Shows
//
//  Created by Filip Hercig on 07.06.2022..
//

import UIKit

// MARK: - AppController

final class AppController {
    
    private let window: UIWindow
    
    var navigationController: UINavigationController? {
        window.rootViewController as? UINavigationController
    }

    init(window: UIWindow) {
        self.window = window
        self.window.rootViewController = UINavigationController()
        self.window.makeKeyAndVisible()
    }
}

// MARK: - Public Methods

extension AppController {
    func startApp() {
        let loginRouter = LoginRouter()
        let loginViewModel = LoginViewModel(router: loginRouter)
        let loginViewController = LoginViewController(viewModel: loginViewModel)
        loginRouter.viewController = loginViewController
        
        navigationController?.setViewControllers([loginViewController], animated: true)
    }
}
