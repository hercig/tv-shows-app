//
//  LoginViewController.swift
//  TV Shows
//
//  Created by Filip Hercig on 17.07.2021..
//

import UIKit


class CustomTextField: UITextField {

    let padding = UIEdgeInsets(top: 0, left: 16, bottom: 13.5, right: 16);

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}

final class LoginViewController: UIViewController {
    
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var rememberMeButton: UIButton!
    
    var rememberMeIsActive = false
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        editTextFieldStyle(for: emailTextField, placeholder: "Email")
        editTextFieldStyle(for: passwordTextField, placeholder: "Password")
        passwordTextField.isSecureTextEntry = true
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    @IBAction func rememberMeButtonTap(_ sender: Any) {
        if rememberMeIsActive {
            rememberMeIsActive = !rememberMeIsActive
            rememberMeButton.setImage(UIImage(named: "ic-checkbox-unselected"), for: .normal)
        } else {
            rememberMeIsActive = !rememberMeIsActive
            rememberMeButton.setImage(UIImage(named: "ic-checkbox-selected"), for: .normal)
        }
    }
    
    
    private func editTextFieldStyle(for field: UITextField, placeholder: String = "") {
        
        let placeholderText = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.5)])
        field.attributedPlaceholder = placeholderText
        
        field.layer.shadowColor = UIColor.white.cgColor
        field.layer.shadowOffset = CGSize(width: 0, height: 1)
        field.layer.shadowOpacity = 1
        field.layer.shadowRadius = 0
        
    }
    
    
    
}
