//
//  LoginViewController.swift
//  TheMovie
//
//  Created by Gerardo on 02/12/22.
//

import UIKit
import Combine
import TPKeyboardAvoidingSwift

class LoginViewController: UIViewController {

    let viewModel: LoginViewModelProtocol
    let viewModelInput: LoginViewModelInput = LoginViewModelInput()
    
    private var subscriptions = Set<AnyCancellable>()
    
    lazy var scrollView: TPKeyboardAvoidingScrollView = {
        var view = TPKeyboardAvoidingScrollView().forAutoLayout()
        view.showsVerticalScrollIndicator = false
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView().forAutoLayout()
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var loadingView: LoadingView = {
        let view = LoadingView().forAutoLayout()
        return view
    }()
    
    lazy var stackView: UIStackView = {
        var view = UIStackView().forAutoLayout()
        view.axis = .vertical
        view.alignment = .center
        view.distribution = .fill
        view.spacing = 20
        return view
    }()
    
    lazy var iconImageView: UIImageView = {
        var view = UIImageView().forAutoLayout()
        view.image = UIImage(named: "themovie")
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    lazy var userNameTextField: UITextField = {
        var view = UITextField().forAutoLayout()
        view.borderStyle = .roundedRect
        view.placeholder = "Username"
        view.font = UIFont.systemFont(ofSize: 14)
        view.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        return view
    }()
    
    lazy var passwordTextField: UITextField = {
        var view = UITextField().forAutoLayout()
        view.borderStyle = .roundedRect
        view.placeholder = "Password"
        view.textContentType = .password
        view.isSecureTextEntry = true
        view.font = UIFont.systemFont(ofSize: 14)
        view.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        return view
    }()
    
    lazy var loginButton: UIButton = {
        var view = UIButton().forAutoLayout()
        view.setTitle("Log in", for: .normal)
        view.backgroundColor = .gray
        view.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        return view
    }()
    
    lazy var errorLabel: UILabel = {
        var view = UILabel().forAutoLayout()
        view.textColor = .orange
        view.numberOfLines = 3
        return view
    }()
    
    init(viewModel: LoginViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func textFieldDidChange() {
        viewModelInput.userInputPublisher.send(userNameTextField.text)
        viewModelInput.passwordInputPublisher.send(passwordTextField.text)
    }
    
    @objc func loginTapped() {
        viewModelInput.loginPublisher.send()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        setupView()
        viewModelInput.viewDidLoadPublisher.send()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        passwordTextField.text = ""
        userNameTextField.text = ""
        textFieldDidChange()
    }
    
    private func bind() {

        let output = viewModel.bind(input: viewModelInput)
        
        output.loginSuccessful.sink { [weak self] message in
            self?.showLoading(show: false)
        }.store(in: &subscriptions)

        
        output.requestingDataPublisher.sink { [weak self] message in
            self?.errorLabel.isHidden = true
            self?.showLoading(show: true)
        }.store(in: &subscriptions)

        output.loginIsEnablePublisher.sink { [weak self] enable in
            self?.loginButton.isEnabled = enable
            self?.loginButton.alpha = enable ? 1.0 : 0.5
        }.store(in: &subscriptions)
        
        output.requestErrorPublisher.sink { [weak self] message in
            self?.errorLabel.isHidden = false
            self?.errorLabel.text = message
            self?.showLoading(show: false)
        }.store(in: &subscriptions)
        
        
    }
   
    func showLoading(show: Bool) {
        show ? loadingView.showInView(view: self.view) : loadingView.remove()
    }
}

extension LoginViewController {
    
    private func setupView() {
        view.backgroundColor = UIColor(rgb: 0x0C151A)
        stackView.addArrangedSubviews(iconImageView, userNameTextField, passwordTextField, loginButton)
        contentView.addSubviews(stackView, errorLabel)
        scrollView.addSubview(contentView)
        view.addSubviews(scrollView)
        setupConstraints()
    }

    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        ])
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            errorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            errorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            errorLabel.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            iconImageView.heightAnchor.constraint(equalToConstant: 100),
            iconImageView.widthAnchor.constraint(equalToConstant: 200)
        ])
        
        NSLayoutConstraint.activate([
            userNameTextField.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            userNameTextField.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            userNameTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            passwordTextField.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50)

        ])
        
        NSLayoutConstraint.activate([
            loginButton.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            loginButton.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            loginButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
    }
}
