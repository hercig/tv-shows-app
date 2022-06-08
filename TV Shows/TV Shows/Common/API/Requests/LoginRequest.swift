//
//  LoginRequest.swift
//  TV Shows
//
//  Created by Filip Hercig on 08.06.2022..
//

import Foundation
import Alamofire

struct LoginRequest: APIRequest {
    
    typealias ResponseType = Model.UserResponse
    
    var path: String {
        return Endpoint.login.path
    }
    
    var query: [String: String]? = [:]
    var httpMethod: HTTPMethod = .post
    var requestBody: Data?
    
    init(username: String, password: String) {
        query?["email"] = username
        query?["password"] = password
    }
}
