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
    
    func sendRequest(on url: String, with params: [String: String], statusHandler: @escaping (Bool) -> Void) {
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
                    case .success(_):
                        SVProgressHUD.showSuccess(withStatus: "Success!")
                        statusHandler(true)
                        
                    case .failure(let error):
                        SVProgressHUD.showError(withStatus: "Error: \(error.errorDescription!)")
                        statusHandler(false)
                }
            }
    }
}
