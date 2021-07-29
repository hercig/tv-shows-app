//
//  networking.swift
//  TV Shows
//
//  Created by Filip Hercig on 21.07.2021..
//

import Foundation
import Alamofire
import SVProgressHUD


class Network {
    
    private let urlBase = "https://tv-shows.infinum.academy"
    
    func loginRegisterRequest(on url: String, with params: [String: String], statusHandler: @escaping (UserResponse?, AFError?, DataResponse<UserResponse, AFError>) -> Void) {
        AF
            .request(
                urlBase + url,
                method: .post,
                parameters: params,
                encoder: JSONParameterEncoder.default
            )
            .validate()
            .responseDecodable(of: UserResponse.self) { response in
                switch response.result {
                    case .success(let userResponse):
                        SVProgressHUD.dismiss()
                        statusHandler(userResponse, nil, response)
                    case .failure(let error):
                        SVProgressHUD.dismiss()
                        statusHandler(nil, error, response)
                }
            }
    }
    
    
    func getShow(with auth: AuthInfo, statusHandler: @escaping (DataResponse<ShowsResponse, AFError>) -> Void) {
        AF
            .request(
                urlBase + "/shows",
                method: .get,
                parameters: [:],
                headers: HTTPHeaders(auth.headers)
            )
            .validate()
            .responseDecodable(of: ShowsResponse.self) { response in
                statusHandler(response)
            }
    }
    
    func getReviews(for show: Show, with auth: AuthInfo, statusHandler: @escaping (DataResponse<ReviewResponse, AFError>) -> Void) {
        AF
            .request(
                urlBase + "/shows/" + String(describing: show.id) + "/reviews",
                method: .get,
                parameters: [:],
                headers: HTTPHeaders(auth.headers)
            )
            .validate()
            .responseDecodable(of: ReviewResponse.self) { response in
                print(show.id)
                statusHandler(response)
            }
    }
}
