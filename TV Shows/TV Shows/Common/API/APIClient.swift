//
//  APIClient.swift
//  TV Shows
//
//  Created by Filip Hercig on 07.06.2022..
//

import Foundation
import Alamofire
import RxSwift

class APIClient {
    static let shared = APIClient()
    private let decoder = JSONDecoder()
    
    private init() {}
    
    func performRequest<T: APIRequest>(_ request: T) -> Single<T.ResponseType> {
        return Single<T.ResponseType>.create { single -> Disposable in
            AF.request(request)
                .validate()
                .responseDecodable(decoder: self.decoder) { (response: DataResponse<T.ResponseType, AFError>) in
                    switch response.result {
                    case .success(let value):
                        single(.success(value))
                    case .failure(let afError):
                        do {
                            let errorResponse = try self.decoder.decode(Model.ErrorResponse.self, from: response.data ?? Data())
                            single(.failure(errorResponse))
                        } catch {
                            single(.failure(afError))
                        }
                    }
                }
            return Disposables.create()
        }
    }
}
