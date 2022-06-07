//
//  Assets.swift
//  TV Shows
//
//  Created by Filip Hercig on 07.06.2022..
//

import UIKit

enum Assets: String {
    
    case loginSplashTopLeft = "splash-top-left"
    case loginSplashTopRight = "splash-top-right"
    case whiteLogo = "logo-white"
    
    var image: UIImage? {
        return UIImage(named: rawValue)
    }
    
    var systemImage: UIImage? {
        return UIImage(systemName: rawValue)
    }
}
