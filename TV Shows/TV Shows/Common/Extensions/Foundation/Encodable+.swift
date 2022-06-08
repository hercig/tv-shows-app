//
//  Encodable+.swift
//  TV Shows
//
//  Created by Filip Hercig on 07.06.2022..
//

import Foundation

extension Encodable {
    var data: Data? {
        if let data = self as? Data {
            return data
        }
        return try? JSONEncoder().encode(self)
    }

    var dictionaryOptional: [String: Any]? {
        guard let data = data else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
}
