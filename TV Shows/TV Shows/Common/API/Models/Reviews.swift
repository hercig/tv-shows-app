//
//  Reviews.swift
//  TV Shows
//
//  Created by Filip Hercig on 07.06.2022..
//

import Foundation

extension Model {
    
    struct Reviews: Decodable {
        let reviews: [Review]
    }

    struct Review: Decodable {
        
        let id: String
        let comment: String
        let rating: Int
        let showId: Int
        let user: User

        enum CodingKeys: String, CodingKey {
            case id
            case comment
            case rating
            case showId = "show_id"
            case user
        }
    }
}
