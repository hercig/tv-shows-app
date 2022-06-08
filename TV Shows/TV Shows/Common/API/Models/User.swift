//
//  User.swift
//  TV Shows
//
//  Created by Filip Hercig on 08.06.2022..
//

import Foundation

extension Model {
    
    struct UserResponse: Codable {
        let user: User
    }

    struct User: Codable {
        let email: String
        let imageUrl: String?
        let id: String

        enum CodingKeys: String, CodingKey {
            case email
            case imageUrl = "image_url"
            case id
        }
    }
}
