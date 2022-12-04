//
//  LoginCoordinator.swift
//  TheMovie
//
//  Created by Gerardo on 02/12/22.
//

import Foundation
import Combine
import UIKit

class ProfileCordinator: Coordinator {
    var children: [Coordinator] = []
    
    private let navigationController: UINavigationController

    private var subscriptions = Set<AnyCancellable>()

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let builder = ProfileSceneBuilder()
        let viewController = builder.build()
        
        viewController.viewModel.output.movieSelectedPublisher
            .sink { [weak self] movieData in
                guard let id = movieData.id else { return }
                self?.cordinateToMovieDetails(movieId: id)
            }.store(in: &subscriptions)
        
    
        navigationController.pushViewController(viewController, animated: true)
    }

    func cordinateToMovieDetails(movieId: Int) {
        let cor = MovieDetailCordinator(navigationController: navigationController, movieId: movieId)
        coordinate(to: cor)
    }
 
}
