//
//  LoginViewController.swift
//  TV Shows
//
//  Created by Filip Hercig on 17.07.2021..
//

import UIKit
import Alamofire
import SVProgressHUD

final class LoginViewController: UIViewController {
    
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var rememberMeButton: UIButton!
    @IBOutlet private weak var loginButton: UIButton!
    
    private var rememberMeIsActive = false
    let network = Network()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        editTextFieldStyle(of: emailTextField, placeholder: "Email")
        editTextFieldStyle(of: passwordTextField, placeholder: "Password")
        passwordTextField.isSecureTextEntry = true
        roundButtonEdges(of: loginButton)
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
}

// MARK: - Style

private extension LoginViewController {
    
    func getTextFielsValue(of textField: UITextField) -> String? {
        let value = textField.text
        return value
    }
    
    func setupUI() {
        rememberMeButton.setImage(UIImage(named: "ic-checkbox-unselected"), for: .normal)
        rememberMeButton.setImage(UIImage(named: "ic-checkbox-selected"), for: .selected)
    }
}

// MARK: - IBActions

private extension LoginViewController {
    
    @IBAction func rememberMeButtonTap(_ sender: Any) {
        rememberMeButton.isSelected.toggle()
    }
    
    @IBAction func didPressLoginButton(_ sender: Any) {
        SVProgressHUD.show()
        
        let params: [String: String] = [
            "email": "fi.hercig@gmail.com",
            "password": "foobar"
//            "email": getTextFielsValue(of: emailTextField) ?? "",
//            "password": getTextFielsValue(of: passwordTextField) ?? ""
        ]
        
        network.loginRegisterRequest(on: "/users/sign_in", with: params, statusHandler: { [weak self] (usrResponse, error, response) in
            if let userResponse = usrResponse {
                let homeStoryboard = UIStoryboard(name: "Home", bundle: nil)
                let authInfo = try? AuthInfo(headers: response.response?.headers.dictionary ?? [:])
                let homeViewController = homeStoryboard.instantiateViewController(withIdentifier: "homeViewController") as! HomeViewController
                
                homeViewController.userResponse = userResponse
                homeViewController.authInfo = authInfo
                self?.navigationController?.setViewControllers([homeViewController], animated: true)
            } else {
                let alertController = UIAlertController(title: "Error", message: error?.errorDescription, preferredStyle: .alert)
                let OKAction = UIAlertAction(title: "OK", style: .default)
                alertController.addAction(OKAction)
                self?.present(alertController, animated: true)
            }
        })
    }
    
    @IBAction func didPressRegisterButton(_ sender: Any) {
        SVProgressHUD.show()
        
        let params: [String: String] = [
            "email": getTextFielsValue(of: emailTextField) ?? "",
            "password": getTextFielsValue(of: passwordTextField) ?? "",
            "password_confirmation": getTextFielsValue(of: passwordTextField) ?? ""
        ]

        network.loginRegisterRequest(on: "/users", with: params, statusHandler: { [weak self] (usrResponse, error, response) in
            if usrResponse != nil {
                let alertController = UIAlertController(
                    title: "Success",
                    message: "Please, login with your credentials.",
                    preferredStyle: .alert
                )
                let OKAction = UIAlertAction(title: "OK", style: .default)
                alertController.addAction(OKAction)
                self?.present(alertController, animated: true)
            } else {
                let alertController = UIAlertController(title: "Error", message: error?.errorDescription, preferredStyle: .alert)
                let OKAction = UIAlertAction(title: "OK", style: .default)
                alertController.addAction(OKAction)
                self?.present(alertController, animated: true)
            }
        })
    }
}
