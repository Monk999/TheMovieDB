//
//  LoginSceneBuilder.swift
//  TheMovie
//
//  Created by Gerardo on 02/12/22.
//

import Foundation
import UIKit

class MoviesSceneBuilder {
    func build() -> MoviesViewController {
        let repository = MoviesRepository()
        let useCase = MoviesUseCase(repository: repository)
        let favoriteUseCase = FavoritesUseCase(repository: FavoritesRepository.shared)
        let viewModel = MoviesViewModel(useCase: useCase, favoriteUseCase: favoriteUseCase)
        let viewController = MoviesViewController(viewModel: viewModel)
        return viewController
    }
}
