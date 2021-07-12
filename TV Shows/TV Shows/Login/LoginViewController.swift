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
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var numberOfTaps = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonElement.layer.cornerRadius = 10
        buttonElement.clipsToBounds = true
        
        let delay = 3
        self.spinner.hidesWhenStopped = true
        self.spinner.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(delay)) {
            self.spinner.stopAnimating()
        }
        
    }
    
    @IBAction func buttonTap(_ sender: Any) {
        
        self.buttonElement.isEnabled = false
        self.spinner.hidesWhenStopped = true
        let delay = 2
        self.spinner.startAnimating()
        
        numberOfTaps += 1
        labelElement.text = "Number of taps: \(numberOfTaps)"
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(delay)) {
            self.spinner.stopAnimating()
            self.buttonElement.isEnabled = true
        
        }
    }
}

