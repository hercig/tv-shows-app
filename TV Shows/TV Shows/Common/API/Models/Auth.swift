//
//  Auth.swift
//  TV Shows
//
//  Created by Filip Hercig on 08.06.2022..
//

import Foundation

extension Model {
    
    struct AuthInfo: Codable {

        let accessToken: String
        let client: String
        let tokenType: String
        let expiry: String
        let uid: String

        enum CodingKeys: String, CodingKey {
            case accessToken = "access-token"
            case client = "client"
            case tokenType = "token-type"
            case expiry = "expiry"
            case uid = "uid"
        }

        // MARK: Helpers
        
        init(headers: [String: String]) throws {
            let data = try JSONSerialization.data(withJSONObject: headers, options: .prettyPrinted)
            let decoder = JSONDecoder()
            self = try decoder.decode(Self.self, from: data)
        }

        var headers: [String: String] {
            do {
                let data = try JSONEncoder().encode(self)
                let jsonObject = try JSONSerialization.jsonObject(with: data, options: [.allowFragments])
                return jsonObject as? [String: String] ?? [:]
            } catch {
                return [:]
            }
        }
    }
}
