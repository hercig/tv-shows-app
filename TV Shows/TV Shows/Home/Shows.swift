//
//  Shows.swift
//  TV Shows
//
//  Created by Filip Hercig on 27.07.2021..
//

import Foundation

struct ShowsResponse: Decodable {
    let shows: [Show]
}

struct Show: Decodable {
    let id: String
    let title: String
    let description: String?
    let imageUrl: URL
    let noOfReviews: Int
    let averageRating: Float?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case description
        case imageUrl = "image_url"
        case noOfReviews = "no_of_reviews"
        case averageRating = "average_rating"
    }
}
