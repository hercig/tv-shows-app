//
//  Endpoint.swift
//  TV Shows
//
//  Created by Filip Hercig on 07.06.2022..
//

import Foundation

enum Endpoint {
    
    case fullPath(String)
    case login
    case getShows
    case getReview(id: Int)
    case createReview

    var path: String {
        switch self {
        case .fullPath:
            return _path
        default:
            return NetworkConstants.baseURLString + _path
        }
    }

    private var _path: String {
        switch self {
        case .fullPath(let path):
            return path
        case .login:
            return "/users"
        case .getShows:
            return "/shows"
        case .getReview(let id):
            return "/shows/\(id)/reviews"
        case .createReview:
            return "/reviews"
    
        }
    }
}
