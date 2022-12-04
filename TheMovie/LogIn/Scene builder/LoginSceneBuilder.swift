//
//  LoginSceneBuilder.swift
//  TheMovie
//
//  Created by Gerardo on 02/12/22.
//

import Foundation
import UIKit

class LoginSceneBuilder {
    func build() -> LoginViewController {
        let useCase = UserLogUseCase.shared
        let profileRepository = ProfileRepository.shared
        let viewModel = LoginViewModel(useCase: useCase, profileUseCase: ProfileUseCase(repository: profileRepository))
        let viewController = LoginViewController(viewModel: viewModel)
        return viewController
    }
}
