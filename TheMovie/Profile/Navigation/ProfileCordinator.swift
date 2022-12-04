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
    
    private let presenter: UIViewController
    private var presented: UIViewController?

    private var subscriptions = Set<AnyCancellable>()

    init(presenter: UIViewController) {
        self.presenter = presenter
    }

    func start() {
        let builder = ProfileSceneBuilder()
        let viewController = builder.build()
        
        viewController.viewModel.output.movieSelectedPublisher
            .sink { [weak self] movieData in
                guard let id = movieData.id else { return }
                self?.cordinateToMovieDetails(movieId: id)
            }.store(in: &subscriptions)
        
        viewController.viewModel.output.closePublisher
            .sink {  [weak self]  in
                self?.cordinateToParent()
            }.store(in: &subscriptions)
        
        presented = viewController
        presenter.present(viewController, animated: true)
    }

    func cordinateToMovieDetails(movieId: Int) {
        let cor = MovieDetailCordinator(presenter: presented!, movieId: movieId)
        coordinate(to: cor)
    }
    
    func cordinateToParent() {
        presenter.dismiss(animated: true)
    }
 
}
