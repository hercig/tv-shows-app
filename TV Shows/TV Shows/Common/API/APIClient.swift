//
//  APIClient.swift
//  TV Shows
//
//  Created by Filip Hercig on 07.06.2022..
//

import Foundation
import Alamofire
import RxSwift

final class APIClient {
    
    static let shared = APIClient()
    private let decoder = JSONDecoder()
    
    private init() {}
    
    func performRequest<T: APIRequest>(_ request: T) -> Single<DataResponse<T.ResponseType, AFError>> {
        return Single<DataResponse<T.ResponseType, AFError>>.create { single -> Disposable in
            AF.request(request)
                .validate()
                .responseDecodable(decoder: self.decoder) { (response: DataResponse<T.ResponseType, AFError>) in
                    switch response.result {
                    case .success:
                        single(.success(response))
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
