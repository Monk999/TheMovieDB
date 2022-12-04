//
//  LoginSceneBuilder.swift
//  TheMovie
//
//  Created by Gerardo on 02/12/22.
//

import Foundation
import UIKit

class MovieDetailSceneBuilder {
    func build(movieID: Int) -> MovieDetailViewController {
        let repository = MovieDetailRepository()
        let useCase = MovieDetailUseCase(repository: repository)
        let favoriteUseCase = FavoritesUseCase(repository: FavoritesRepository.shared)
        let viewModel = MovieDetailViewModel(
            useCase: useCase,
            favoriteUseCase: favoriteUseCase,
            movieId: movieID)
        let viewController = MovieDetailViewController(viewModel: viewModel)
        return viewController
    }
}
