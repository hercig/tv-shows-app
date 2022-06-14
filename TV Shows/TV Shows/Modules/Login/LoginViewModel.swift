//
//  LoginViewModel.swift
//  TV Shows
//
//  Created by Filip Hercig on 08.06.2022..
//

import Foundation
import RxSwift

protocol LoginViewModeling {
    var loadStatus: Observable<LoadStatus> { get }
    
    func handleLoginButtonTap(username: String?, password: String?)
    func handleRegisterButtonTap(username: String?, password: String?)
}

final class LoginViewModel {
    
    private let disposeBag = DisposeBag()
    private let userService: UserServicing
    private let router: LoginRouting
    
    private let loadStatusSubject = PublishSubject<LoadStatus>()
    
    init(router: LoginRouter, userService: UserService = UserService()) {
        self.router = router
        self.userService = userService
    }
}

extension LoginViewModel: LoginViewModeling {
    
    // Observables
    
    var loadStatus: Observable<LoadStatus> {
        loadStatusSubject.asObservable()
    }
    
    // Communication with ViewController
    
    func handleLoginButtonTap(username: String?, password: String?) {
        guard let username = username, let password = password else { return }
        
        loadStatusSubject.onNext(.loading)
        userService
            .loginUser(username: username, password: password)
            .subscribe(
                onNext: { [weak self] response in
                    switch response.result {
                    case .success(let userResponse):
                        guard let headers = response.response?.headers.dictionary else { return }
                        try? UserDefaultsStorage.shared.authInfo = Model.AuthInfo(headers: headers)
                        UserDefaultsStorage.shared.currentUser = userResponse.user
                        self?.loadStatusSubject.onNext(.none)
                    default:
                        break
                    }
                },
                onError: { [weak self] error in
                    self?.loadStatusSubject.onNext(.error(error))
                }
            )
            .disposed(by: disposeBag)
    }
    
    func handleRegisterButtonTap(username: String?, password: String?) {
        guard let username = username, let password = password else { return }
        NotificationCenter.default.addObserver(self, selector: #selector(handleLogout), name: .logoutNotification, object: nil)
        
        loadStatusSubject.onNext(.loading)
        userService
            .registerUser(username: username, password: password)
            .subscribe(
                onNext: { [weak self] response in
                    switch response.result {
                    case .success(let userResponse):
                        UserDefaultsStorage.shared.currentUser = userResponse.user
                        self?.loadStatusSubject.onNext(.none)
                    default:
                        break
                    }
                },
                onError: { [weak self] error in
                    self?.loadStatusSubject.onNext(.error(error))
                }
            )
            .disposed(by: disposeBag)
    }

    @objc
    private func handleLogout() {
        // Clear userDefaults
        // Navigate to logout screen
    }
}

extension NSNotification.Name { 
    static let logoutNotification = NSNotification.Name("logoutNotification")
}
