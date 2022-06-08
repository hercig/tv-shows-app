//
//  HomeRouter.swift
//  TV Shows
//
//  Created by Filip Hercig on 08.06.2022..
//

import Foundation

protocol HomeRouting {
    func navigateToHomeViewController()
}

final class HomeRouter: HomeRouting {
    
    weak var viewController: LoginViewController?
    
    func navigateToHomeViewController() {}
}
