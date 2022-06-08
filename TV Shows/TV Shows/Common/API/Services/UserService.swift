//
//  UserService.swift
//  TV Shows
//
//  Created by Filip Hercig on 07.06.2022..
//

import Foundation
import Alamofire
import RxSwift

protocol UserServicing {
    func loginUser(username: String, password: String) -> Observable<DataResponse<Model.UserResponse, AFError>>
    func registerUser(username: String, password: String) -> Observable<DataResponse<Model.UserResponse, AFError>>
}

final class UserService: UserServicing {
    func loginUser(username: String, password: String) -> Observable<DataResponse<Model.UserResponse, AFError>> {
        let request = LoginRequest(username: username, password: password)
        
        return APIClient
            .shared
            .performRequest(request)
            .asObservable()
    }
    
    func registerUser(username: String, password: String) -> Observable<DataResponse<Model.UserResponse, AFError>> {
        let request = RegisterRequest(username: username, password: password)
        
        return APIClient
            .shared
            .performRequest(request)
            .asObservable()
    }
}
