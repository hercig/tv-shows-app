//
//  String+.swift
//  TV Shows
//
//  Created by Filip Hercig on 07.06.2022..
//

import Foundation

extension String {
    
    var isBlank: Bool {
        return trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    var toURL: URL? {
        return URL(string: self)
    }
}
