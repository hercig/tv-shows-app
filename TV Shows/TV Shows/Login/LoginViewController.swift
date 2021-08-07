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

    private let encoder = PropertyListEncoder()
    private let decoder = PropertyListDecoder()
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
        
        if
            let authInfo = loadAuthData(),
            let userRespose = loadUserData()
        {
            let homeStoryboard = UIStoryboard(name: "Home", bundle: nil)
            let homeViewController = homeStoryboard.instantiateViewController(withIdentifier: "homeViewController") as! HomeViewController
            homeViewController.authInfo = authInfo
            homeViewController.userResponse = userRespose
            
            navigationController?.setViewControllers([homeViewController], animated: true)
        } else {
            print("Nema DATEEEEE")
        }
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
    
    func animateTextField(_ field: UITextField) {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 3
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: field.center.x - 10, y: field.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: field.center.x + 10, y: field.center.y))

        field.layer.add(animation, forKey: "position")
    }
}

// MARK: - Saving Login Data

private extension LoginViewController {
    
    func loadAuthData() -> AuthInfo? {
        if
            let authData = UserDefaults.standard.data(
                forKey: Constants.Defaults.authInfo.rawValue
            ),
            let authInfo = try? decoder.decode(AuthInfo.self, from: authData)
        {
            return authInfo
        }
        
        return nil
    }
    
    func loadUserData() -> UserResponse? {
        if
            let userData = UserDefaults.standard.data(
                forKey: Constants.Defaults.userResponse.rawValue
            ),
            let userResponse = try? decoder.decode(UserResponse.self, from: userData)
        {
            return userResponse
        }
        return nil
    }
    
    func saveAuthInfo(state: AuthInfo) {
        if let encoded = try? encoder.encode(state) {
            UserDefaults.standard.set(
                encoded,
                forKey: Constants.Defaults.authInfo.rawValue
            )
        }
    }
    
    func saveUserData(state: UserResponse) {
        if let encoded = try? encoder.encode(state) {
            UserDefaults.standard.set(
                encoded,
                forKey: Constants.Defaults.userResponse.rawValue
            )
        }
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
        
        network.loginRegisterRequest(
            on: "/users/sign_in",
            with: params,
            statusHandler: { [weak self] (usrResponse, error, response) in
                guard let self = self else { return }
                
                if let userResponse = usrResponse {
                    // creating instance of HomeViewController
                    let homeStoryboard = UIStoryboard(name: "Home", bundle: nil)
                    let authInfo = try? AuthInfo(headers: response.response?.headers.dictionary ?? [:])
                    let homeViewController = homeStoryboard.instantiateViewController(withIdentifier: "homeViewController") as! HomeViewController
                    
                    // passing data to HomeViewController
                    homeViewController.userResponse = userResponse
                    homeViewController.authInfo = authInfo
                    
                    // saving login data to UserDefaults
                    if self.rememberMeButton.state == .selected {
                        self.saveAuthInfo(state: authInfo!)
                        self.saveUserData(state: userResponse)
                    }
                    
                    self.navigationController?.setViewControllers([homeViewController], animated: true)
                } else {
                    self.animateTextField((self.passwordTextField)!)
                    self.animateTextField((self.emailTextField)!)
                }
            }
        )
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
