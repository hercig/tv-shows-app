//
//  UserDefaultsStorage.swift
//  TV Shows
//
//  Created by Filip Hercig on 08.06.2022..
//

import UIKit

enum UserDefaultsKey: String {
    case currentUser
    
    var key: String {
        switch self {
        case .currentUser:
            return "currentUser"
        }
    }
}

protocol UserDefaultsStoring: AnyObject {
    var currentUser: Model.User? { get set }
    func clearUserData(except keys: [String])
}

final class UserDefaultsStorage: UserDefaultsStoring {
    
    static let shared = UserDefaultsStorage()
    private let userDefaults = UserDefaults.standard
    
    private init() {}
    
    var currentUser: Model.User? {
        get {
            guard let user = userDefaults.data(forKey: UserDefaultsKey.currentUser.key) else { return nil }
            return try? PropertyListDecoder().decode(Model.User.self, from: user)
        }
        set {
            userDefaults.set(try? PropertyListEncoder().encode(newValue), forKey: UserDefaultsKey.currentUser.key)
        }
    }
    
    func clearUserData(except keys: [String] = []) {
        UserDefaults.clearAllKeysAndValues(except: keys)
    }
}
