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
    
    func showSpinner(for delay: Int) -> Void {
        self.buttonElement.isEnabled = false
        self.spinner.hidesWhenStopped = true
        self.spinner.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(delay)) {
            self.spinner.stopAnimating()
            self.buttonElement.isEnabled = true
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.showSpinner(for: 3)
        
        buttonElement.layer.cornerRadius = 10
        buttonElement.clipsToBounds = true
        
    }
    
    @IBAction func buttonTap(_ sender: Any) {
        
        self.showSpinner(for: 2)
        
        numberOfTaps += 1
        labelElement.text = "Number of taps: \(numberOfTaps)"
      
    }
}

