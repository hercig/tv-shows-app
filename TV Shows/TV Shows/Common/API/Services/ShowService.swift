//
//  ShowService.swift
//  TV Shows
//
//  Created by Filip Hercig on 07.06.2022..
//

import Foundation
import RxSwift

protocol ShowServicing {
    func getShows() -> Observable<Model.Shows>
}

final class ShowService: ShowServicing {
    
    func getShows() -> Observable<Model.Shows> {
        let request = ShowsRequest()
        
        return APIClient
            .shared
            .performRequest(request)
            .asObservable()
    }
}
