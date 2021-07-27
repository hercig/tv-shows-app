//
//  HomeViewController.swift
//  TV Shows
//
//  Created by Filip Hercig on 20.07.2021..
//

import UIKit

class HomeViewController: UIViewController {
    
    var userResponse: UserResponse?
    var authInfo: AuthInfo?
    
    @IBOutlet private weak var testLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Force unwrapped because this screen wouldn't show without proper userResponse
        testLabel.text = "Hello \(userResponse!.user.email)"
    }
}
