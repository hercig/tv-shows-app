//
//  Optional+.swift
//  TV Shows
//
//  Created by Filip Hercig on 07.06.2022..
//

import Foundation

extension Optional where Wrapped == String {
    var isEmptyOrNil: Bool {
        if let unwrapped = self {
            return unwrapped.isBlank
        } else {
            return true
        }
    }
}

extension Optional where Wrapped == Bool {
    var isNilOrFalse: Bool {
        return !(self ?? false)
    }
}

extension Optional where Wrapped == [String: String] {
    var isEmptyOrNil: Bool {
        if let dictionary = self {
            return dictionary.isEmpty
        } else {
            return true
        }
    }
}
