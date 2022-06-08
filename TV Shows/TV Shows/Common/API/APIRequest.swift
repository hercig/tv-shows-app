//
//  APIRequest.swift
//  TV Shows
//
//  Created by Filip Hercig on 07.06.2022..
//

import Foundation
import Alamofire
import RxSwift

protocol APIRequest: URLRequestConvertible {
    associatedtype ResponseType: Decodable

    var path: String { get }
    var query: [String: String]? { get }
    var httpMethod: HTTPMethod { get }
    var requestBody: Data? { get }
}

extension APIRequest {
    func asURLRequest() throws -> URLRequest {
        let url = URL(string: path)!

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod.rawValue
        urlRequest.httpBody = requestBody
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        query.isEmptyOrNil ? () : query?.forEach { urlRequest.url?.appendQueryItem(name: $0.key, value: $0.value) }

        return urlRequest
    }
}
