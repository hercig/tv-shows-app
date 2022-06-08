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
                onNext: { response in
                    print(response.user.email)
                },
                onError: { error in
                    print(error.localizedDescription) // TODO: Handle error by displaying an alert
                }
            )
            .disposed(by: disposeBag)
    }
    
    func handleRegisterButtonTap(username: String?, password: String?) {
        guard let username = username, let password = password else { return }
        
        loadStatusSubject.onNext(.loading)
        userService
            .registerUser(username: username, password: password)
            .subscribe(
                onNext: { [weak self] response in
                    print(response)
                    self?.loadStatusSubject.onNext(.none)
                },
                onError: { [weak self] error in
                    print(error.localizedDescription) // TODO: Handle error by displaying an alert
                    self?.loadStatusSubject.onNext(.none)
                }
            )
            .disposed(by: disposeBag)
    }
}
