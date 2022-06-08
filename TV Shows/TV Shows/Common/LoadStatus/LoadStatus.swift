//
//  LoadStatus.swift
//  TV Shows
//
//  Created by Filip Hercig on 08.06.2022..
//

import Foundation

enum LoadStatus {
    case loading
    case error(Error)
    case none
    
    var isLoading: Bool {
        switch self {
        case .loading:
            return true
        default:
            return false
        }
    }
}
