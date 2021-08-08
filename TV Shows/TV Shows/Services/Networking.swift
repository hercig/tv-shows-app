//
//  networking.swift
//  TV Shows
//
//  Created by Filip Hercig on 21.07.2021..
//

import Foundation
import Alamofire
import SVProgressHUD

struct ReviewParameters: Codable {
    let rating: Int
    let comment: String
    let show_id: Int
}

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
        SVProgressHUD.show()
        AF
            .request(
                urlBase + "/shows/" + String(describing: show.id) + "/reviews",
                method: .get,
                parameters: [:],
                headers: HTTPHeaders(auth.headers)
            )
            .validate()
            .responseDecodable(of: ReviewResponse.self) { response in
                statusHandler(response)
            }
    }
    
    func submitShowReview(with params: ReviewParameters, auth: AuthInfo, statusHandler: @escaping (Bool) -> Void) {
        SVProgressHUD.show()
        let requestParameters = params
        let encoder = JSONEncoder()
        guard let data = try? encoder.encode(requestParameters) else {
            return
        }
        let url = URL(string: urlBase + "/reviews")!
        var urlRequest = URLRequest(url: url)

        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = data
        urlRequest.allHTTPHeaderFields = auth.headers
        urlRequest.httpMethod = "POST"
        
        AF
            .request(urlRequest)
            .responseString { response in
                switch response.result {
                    case .success(_):
                        statusHandler(true)
                    case .failure(let error):
                        print(error.localizedDescription)
                        statusHandler(false)
                }
        }
    }
    
    func getMyInfo(with auth: AuthInfo, statusHandler: @escaping (UserResponse) -> Void) {
        SVProgressHUD.show()
        AF
            .request(
                urlBase + "/users/me",
                method: .get,
                parameters: [:],
                headers: HTTPHeaders(auth.headers)
            )
            .validate()
            .responseDecodable(of: UserResponse.self) { response in
                switch response.result {
                case .success(let userResponse):
                    statusHandler(userResponse)
                    SVProgressHUD.dismiss()
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                    SVProgressHUD.dismiss()
                }
            }
    }
}
