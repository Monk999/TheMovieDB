//
//  LoginSceneBuilder.swift
//  TheMovie
//
//  Created by Gerardo on 02/12/22.
//

import Foundation
import UIKit

class ProfileSceneBuilder {
    func build() -> ProfileViewController {
        let repository = ProfileRepository.shared
        let useCase = ProfileUseCase(repository: repository)
        let favoriteUseCase = FavoritesUseCase(repository: FavoritesRepository.shared)
        let viewModel = ProfileViewModel(useCase: useCase, favoriteUseCase: favoriteUseCase)
        let viewController = ProfileViewController(viewModel: viewModel)
        return viewController
    }
}
