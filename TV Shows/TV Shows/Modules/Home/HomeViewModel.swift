//
//  HomeViewModel.swift
//  TV Shows
//
//  Created by Filip Hercig on 08.06.2022..
//

import Foundation
import RxSwift

protocol HomeViewModeling {
    
}

final class HomeViewModel {
    
    private let router: HomeRouting
    private let showService: ShowServicing
    
    init(router: HomeRouter, showService: ShowService = ShowService()) {
        self.router = router
        self.showService = showService
    }
    
    private func getShows() {
        
    }
}

extension HomeViewModel: HomeViewModeling {
    
}
