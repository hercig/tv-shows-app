//
//  LoginViewController.swift
//  TV Shows
//
//  Created by Filip Hercig on 17.07.2021..
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import SVProgressHUD

final class LoginViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    private let viewModel: LoginViewModeling
    
    private lazy var topLeftSplashImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = Assets.loginSplashTopLeft.image
        
        return imageView
    }()
    
    private lazy var topRightSplashImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = Assets.loginSplashTopRight.image
        
        return imageView
    }()
    
    private lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = Assets.whiteLogo.image
        
        return imageView
    }()
    
    private lazy var loginTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 34, weight: .bold)
        label.textColor = .white
        label.text = "Login"
        
        return label
    }()
    
    private lazy var loginSubtitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .white
        label.text = "In order to continue please log in"
        
        return label
    }()
    
    private lazy var emailTextField: PaddedTextField = {
        let field = PaddedTextField()
        field.textColor = .white
        field.autocapitalizationType = .none
        field.keyboardType = .emailAddress
        field.addBottomLine()
        field.addAtributtedPlaceholder("Email")
        
        return field
    }()
    
    private lazy var passwordTextField: PaddedTextField = {
        let field = PaddedTextField()
        field.textColor = .white
        field.autocapitalizationType = .none
        field.isSecureTextEntry = true
        field.addBottomLine()
        field.addAtributtedPlaceholder("Password")
        
        return field
    }()
    
    private lazy var rememberMeCheckboxButton: UIButton = {
        let button = UIButton()
        button.setImage(Assets.checkboxUnselected.image, for: .normal)
        button.setImage(Assets.checkboxSelected.image, for: .selected)
        
        return button
    }()
    
    private lazy var rememberMeHintLabel: UILabel = {
        let label = UILabel()
        label.text = "Remember me"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 17)
        
        return label
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .white
        button.setTitle("Login", for: .normal)
        button.setTitleColor(UIColor.appPurple, for: .normal)
        button.layer.cornerRadius = 22
        button.clipsToBounds = true
        
        return button
    }()
    
    private lazy var registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Register", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        
        return button
    }()
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        addSubviews()
        setConstraints()
        observe()
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

// MARK: - Setup View

private extension LoginViewController {
    
    func setupUI() {
        view.backgroundColor = .appPurple
    }
    
    func addSubviews() {
        view.addSubview(topLeftSplashImageView)
        view.addSubview(topRightSplashImageView)
        view.addSubview(logoImageView)
        view.addSubview(loginTitleLabel)
        view.addSubview(loginSubtitleLabel)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(rememberMeCheckboxButton)
        view.addSubview(rememberMeHintLabel)
        view.addSubview(loginButton)
        view.addSubview(registerButton)
    }
    
    func setConstraints() {
        topLeftSplashImageView.snp.remakeConstraints {
            $0.top.leading.equalToSuperview()
            $0.width.equalTo(140)
            $0.height.equalTo(100)
        }
        
        topRightSplashImageView.snp.remakeConstraints {
            $0.top.trailing.equalToSuperview()
            $0.width.equalTo(202)
            $0.height.equalTo(266)
        }
        
        logoImageView.snp.remakeConstraints {
            $0.top.equalToSuperview().offset(120)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(162)
            $0.height.equalTo(38)
        }
        
        loginTitleLabel.snp.remakeConstraints {
            $0.top.equalTo(topLeftSplashImageView.snp.bottom).offset(90)
            $0.leading.equalToSuperview().offset(20)
            $0.height.equalTo(40)
        }
        
        loginSubtitleLabel.snp.remakeConstraints {
            $0.top.equalTo(loginTitleLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(20)
            $0.height.equalTo(21)
        }
        
        emailTextField.snp.remakeConstraints {
            $0.top.equalTo(loginSubtitleLabel.snp.bottom).offset(45)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(48)
        }
        
        passwordTextField.snp.remakeConstraints {
            $0.top.equalTo(emailTextField.snp.bottom).offset(25)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(48)
        }
        
        rememberMeCheckboxButton.snp.remakeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(20)
            $0.width.height.equalTo(28)
        }
        
        rememberMeHintLabel.snp.remakeConstraints {
            $0.centerY.equalTo(rememberMeCheckboxButton)
            $0.leading.equalTo(rememberMeCheckboxButton.snp.trailing).offset(6)
        }
        
        loginButton.snp.remakeConstraints {
            $0.top.equalTo(rememberMeCheckboxButton.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(44)
        }
        
        registerButton.snp.remakeConstraints {
            $0.top.equalTo(loginButton.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(40)
        }
    }
    
    func observe() {
        rememberMeCheckboxButton
            .rx.tap
            .subscribe(onNext: { [weak self] in
                self?.rememberMeCheckboxButton.isSelected.toggle()
            })
            .disposed(by: disposeBag)
        
        loginButton
            .rx.tap
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                
                self.viewModel.handleLoginButtonTap(
                    username: self.emailTextField.text,
                    password: self.passwordTextField.text
                )
            })
            .disposed(by: disposeBag)
        
        registerButton
            .rx.tap
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.viewModel.handleRegisterButtonTap(
                    username: self.emailTextField.text,
                    password: self.passwordTextField.text
                )
            })
            .disposed(by: disposeBag)
        
        viewModel
            .loadStatus
            .subscribe(onNext: { loadStatus in
                
            })
            .disposed(by: disposeBag)
    }
}
