//
//  RegisterRequest.swift
//  TV Shows
//
//  Created by Filip Hercig on 08.06.2022..
//

import Foundation
import Alamofire

struct RegisterRequest: APIRequest {
    
    typealias ResponseType = Model.UserResponse
    
    var path: String {
        return Endpoint.register.path
    }
    
    var query: [String: String]? = [:]
    var httpMethod: HTTPMethod = .post
    var requestBody: Data?
    
    init(username: String, password: String) {
        query?["email"] = username
        query?["password"] = password
    }
}
