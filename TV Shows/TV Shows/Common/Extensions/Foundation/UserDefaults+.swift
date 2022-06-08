//
//  UserDefaults+.swift
//  TV Shows
//
//  Created by Filip Hercig on 08.06.2022..
//

import Foundation

extension UserDefaults {
    static func clearAllKeysAndValues(except exceptedKeys: [String] = []) {
        UserDefaults.standard.dictionaryRepresentation().keys.forEach { key in
            if !exceptedKeys.contains(key) {
                UserDefaults.standard.removeObject(forKey: key)
            }
        }
    }
}
