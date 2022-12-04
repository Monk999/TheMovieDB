//
//  LoginSceneBuilder.swift
//  TheMovie
//
//  Created by Gerardo on 02/12/22.
//

import UIKit
import Combine

final class LoginViewModel: LoginViewModelProtocol {
        
    var output: LoginViewModelOutput = LoginViewModelOutput()

    private var subscriptions = Set<AnyCancellable>()
    
    private let useCase: UserLogUseCaseProtocol
    
    private let profileUseCase: ProfileUseCaseProtocol

    private var userText: String? {
        didSet {
            checkLoginIsEnable()
        }
    }
    
    private var passwordText: String? {
        didSet {
            checkLoginIsEnable()
        }
    }

    private var loginIsEnable: Bool = false {
        didSet {
            output.loginIsEnablePublisher.send(loginIsEnable)
        }
    }

    init(useCase: UserLogUseCaseProtocol, profileUseCase: ProfileUseCaseProtocol) {
        self.profileUseCase = profileUseCase
        self.useCase = useCase
    }

    func bind(input: LoginViewModelInput) -> LoginViewModelOutput {
        input.viewDidLoadPublisher.sink { [weak self] in
            self?.checkLoginIsEnable()
        }.store(in: &subscriptions)
        
        input.loginPublisher.sink { [weak self] in
            self?.login()
        }.store(in: &subscriptions)

        input.passwordInputPublisher.sink { [weak self] text in
            self?.passwordText = text?.trimmingCharacters(in: .whitespacesAndNewlines)
        }.store(in: &subscriptions)
        
        input.userInputPublisher.sink { [weak self] text in
            self?.userText = text?.trimmingCharacters(in: .whitespacesAndNewlines)
        }.store(in: &subscriptions)

        return output
    }
    
    private func checkLoginIsEnable() {
        guard let userText = userText,
              let passwordText = passwordText,
              !userText.isEmpty,
              !passwordText.isEmpty
        else {
            loginIsEnable = false
            return
        }
        
        loginIsEnable = true
    }
    
    private func login() {
        guard let userText = userText,
              let passwordText = passwordText
        else {
            return
        }
        
        output.requestingDataPublisher.send()
        
        useCase.login(user: userText, password: passwordText)
            .sink { [weak self] result in
                
                if case .failure(let error) = result,
                   case .genericError(let message) = error {
                    self?.output.requestErrorPublisher.send(message)
                }
                
            } receiveValue: { [weak self]  in
                self?.profileUseCase.saveName(name: userText)
                self?.output.loginSuccessful.send()
                
            }.store(in: &subscriptions)
    }
}
