//
//  LoginViewController.swift
//  TV Shows
//
//  Created by Filip Hercig on 12.07.2021..
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var labelElement: UILabel!
    @IBOutlet weak var buttonElement: UIButton!
    
    var numberOfTaps = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonElement.layer.cornerRadius = 10
        buttonElement.clipsToBounds = true
        
    }
    
    @IBAction func buttonTap(_ sender: Any) {
        numberOfTaps += 1
        labelElement.text = "Number of taps: \(numberOfTaps)"
    }
    
}

