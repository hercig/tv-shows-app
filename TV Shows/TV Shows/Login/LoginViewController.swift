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
    var userResponse: UserResponse? = nil
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        editTextFieldStyle(of: emailTextField, placeholder: "Email")
        editTextFieldStyle(of: passwordTextField, placeholder: "Password")
        passwordTextField.isSecureTextEntry = true
        
        roundButtonEdges(of: loginButton)
        SVProgressHUD.setDefaultMaskType(.black)
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
    
    
    private func getTextFielsValue(of textField: UITextField) -> String? {
        let value = textField.text
        return value
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
        
        SVProgressHUD.show()
        
        let params: [String: String] = [
            
//            TODO: Uncomment before commit

            "email": getTextFielsValue(of: emailTextField) ?? "",
            "password": getTextFielsValue(of: passwordTextField) ?? ""
            
//            "email": "fi.hercig@gmail.com",
//            "password": "foobar"
        ]
        
        AF
            .request(
                "https://tv-shows.infinum.academy/users/sign_in",
                method: .post,
                parameters: params,
                encoder: JSONParameterEncoder.default
            )
            .validate()
            .responseDecodable(of: UserResponse.self) { [weak self] response in
                
                switch response.result {
                    case .success(_):
                        SVProgressHUD.showSuccess(withStatus: "Success!")
                        
                        let homeStoryboard = UIStoryboard(name: "Home", bundle: nil)
                        let homeViewController = homeStoryboard.instantiateViewController(withIdentifier: "homeViewController") as! HomeViewController
                        self?.navigationController?.pushViewController(homeViewController, animated: true)
                        
                    case .failure(let error):
                        SVProgressHUD.showError(withStatus: "Error: \(error.errorDescription!)")
                }
            }
    }
    
    @IBAction private func didPressRegisterButton(_ sender: Any) {
        
        SVProgressHUD.show()
        
        let params: [String: String] = [
            "email": getTextFielsValue(of: emailTextField) ?? "",
            "password": getTextFielsValue(of: passwordTextField) ?? "",
            "password_confirmation": getTextFielsValue(of: passwordTextField) ?? ""
        ]
        
        AF
            .request(
                "https://tv-shows.infinum.academy/users",
                method: .post,
                parameters: params,
                encoder: JSONParameterEncoder.default
            )
            .validate()
            .responseJSON(completionHandler: { [weak self] response in
                
                switch response.result {
                case .success(_):
                    
                    SVProgressHUD.showSuccess(withStatus: "Success!")
                    
                    let homeStoryboard = UIStoryboard(name: "Home", bundle: nil)
                    let homeViewController = homeStoryboard.instantiateViewController(withIdentifier: "homeViewController") as! HomeViewController
                    self?.navigationController?.pushViewController(homeViewController, animated: true)
                    
                case .failure(let error):
                    SVProgressHUD.showError(withStatus: "Error: \(error.errorDescription!)")
                }
            })
    }
    
    
}
