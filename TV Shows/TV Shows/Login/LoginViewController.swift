//
//  LoginViewController.swift
//  TV Shows
//
//  Created by Filip Hercig on 12.07.2021..
//

import UIKit
import SVProgressHUD

final class LoginViewController: UIViewController {
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var incrementButton: UIButton!
    @IBOutlet private weak var spinner: UIActivityIndicatorView!
    
    private var numberOfTaps = 0
    
    
    private func showSpinner(for delay: Int) {
        
        incrementButton.isEnabled = false
        spinner.hidesWhenStopped = true
        spinner.startAnimating()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(delay)) { [weak self] in
            self?.spinner.stopAnimating()
            self?.incrementButton.isEnabled = true
        }

    }

    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        decorateButton()
        showSpinner(for: 3)
        
    }
    
    
    private func decorateButton() {
        
        incrementButton.layer.cornerRadius = 10
        incrementButton.clipsToBounds = true
        
    }
    
    
    @IBAction func buttonTap() {
        
        showSpinner(for: 2)
        
        numberOfTaps += 1
        titleLabel.text = "Number of taps: \(numberOfTaps)"
      
    }
    
}
