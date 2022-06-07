//
//  Data+.swift
//  TV Shows
//
//  Created by Filip Hercig on 07.06.2022..
//

import Foundation

extension Data {
    func parseError() -> NSError {
        let data = self
        guard let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments),
              let dict = json as? [String: Any]
        else {
            return NSError(domain: "", code: 0, userInfo: nil)
        }
        let code = dict["Code"] as? Int ?? 0
        let message = dict["Message"] as? String ?? ""
        return NSError(domain: message, code: code, userInfo: nil)
    }
}
