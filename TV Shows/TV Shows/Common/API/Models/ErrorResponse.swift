//
//  ErrorResponse.swift
//  TV Shows
//
//  Created by Filip Hercig on 07.06.2022..
//

import Foundation

extension Model {
    struct ErrorResponse: Codable, Error {
        public let type: String
        public let title: String
        public let status: Int
        public let detail: String?
        public let path: String?
        public let message: String?
        
        public init(type: String, title: String, status: Int, detail: String?, path: String?, message: String?) {
            self.type = type
            self.title = title
            self.status = status
            self.detail = detail
            self.path = path
            self.message = message
        }
    }
}
