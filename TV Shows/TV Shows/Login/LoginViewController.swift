//
//  LoginViewController.swift
//  TV Shows
//
//  Created by Filip Hercig on 17.07.2021..
//

import UIKit


final class CustomTextField: UITextField {

    private let padding = UIEdgeInsets(top: 0, left: 16, bottom: 10, right: 16);

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
    @IBOutlet private weak var loginButton: UIButton!
    
    private var rememberMeIsActive = false
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        editTextFieldStyle(of: emailTextField, placeholder: "Email")
        editTextFieldStyle(of: passwordTextField, placeholder: "Password")
        passwordTextField.isSecureTextEntry = true
        
        roundButtonEdges(of: loginButton)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    private func editTextFieldStyle(of field: UITextField, placeholder: String = "") {
        
        // Changing placeholder style
        let placeholderText = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.5)])
        field.attributedPlaceholder = placeholderText
        
        // Adding bottom border line
        field.layer.shadowColor = UIColor.white.cgColor
        field.layer.shadowOffset = CGSize(width: 0, height: 1)
        field.layer.shadowOpacity = 1
        field.layer.shadowRadius = 0
    }
    
    private func roundButtonEdges(of button: UIButton) {
        
        button.layer.cornerRadius = 21.5
        button.clipsToBounds = true
    }
    
    @IBAction private func rememberMeButtonTap(_ sender: Any) {
        
        if rememberMeIsActive {
            rememberMeIsActive = !rememberMeIsActive
            rememberMeButton.setImage(UIImage(named: "ic-checkbox-unselected"), for: .normal)
        } else {
            rememberMeIsActive = !rememberMeIsActive
            rememberMeButton.setImage(UIImage(named: "ic-checkbox-selected"), for: .normal)
        }
    }
    
    @IBAction private func didPressLoginButton(_ sender: Any) {
        
        let homeStoryboard = UIStoryboard(name: "Home", bundle: nil)
        let homeViewController = homeStoryboard.instantiateViewController(withIdentifier: "homeViewController") as! HomeViewController
        
        navigationController?.pushViewController(homeViewController, animated: true)
    }
    
    @IBAction private func didPressRegisterButton(_ sender: Any) {
        didPressLoginButton(sender)
    }
    
    
}
