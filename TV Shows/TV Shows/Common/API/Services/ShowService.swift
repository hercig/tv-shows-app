//
//  ShowService.swift
//  TV Shows
//
//  Created by Filip Hercig on 07.06.2022..
//

import Foundation
import Alamofire
import RxSwift

protocol ShowServicing {
    func getShows() -> Observable<DataResponse<Model.Shows, AFError>>
}

final class ShowService: ShowServicing {
    
    func getShows() -> Observable<DataResponse<Model.Shows, AFError>> {
        let request = ShowsRequest()
        
        return APIClient
            .shared
            .performRequest(request)
            .asObservable()
    }
}
