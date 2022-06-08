//
//  UserService.swift
//  TV Shows
//
//  Created by Filip Hercig on 07.06.2022..
//

import Foundation
import RxSwift

protocol UserServicing {
    func loginUser(username: String, password: String) -> Observable<Model.UserResponse>
    func registerUser(username: String, password: String) -> Observable<Model.UserResponse>
}

final class UserService: UserServicing {
    func loginUser(username: String, password: String) -> Observable<Model.UserResponse> {
        let request = LoginRequest(username: username, password: password)
        
        return APIClient
            .shared
            .performRequest(request)
            .asObservable()
    }
    
    func registerUser(username: String, password: String) -> Observable<Model.UserResponse> {
        let request = RegisterRequest(username: username, password: password)
        
        return APIClient
            .shared
            .performRequest(request)
            .asObservable()
    }
}
