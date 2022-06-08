//
//  ShowsRequest.swift
//  TV Shows
//
//  Created by Filip Hercig on 07.06.2022..
//

import Foundation
import Alamofire

struct ShowsRequest: APIRequest {
    
    typealias ResponseType = Model.Shows
    
    var path: String {
        return Endpoint.getShows.path
    }
    
    var query: [String: String]?
    var httpMethod: HTTPMethod = .get
    var requestBody: Data?
}
