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
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    func call<Model: Decodable>(
        of type: Model.Type,
        url: String,
        params: [String: String]?,
        router: URLRequestConvertible,
        responseHandler: ((DataResponse<Model, AFError>) -> Void)?
    ) {
        AF
            .request(
                urlBase + url,
                method: .post,
                parameters: params,
                encoder: JSONParameterEncoder.default
            )
            .validate()
            .responseDecodable(of: Model.self) { dataResponse in
                responseHandler?(dataResponse)
            }
    }
}
