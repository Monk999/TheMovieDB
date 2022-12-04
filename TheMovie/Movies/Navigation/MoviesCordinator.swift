//
//  LoginCoordinator.swift
//  TheMovie
//
//  Created by Gerardo on 02/12/22.
//

import Foundation
import Combine
import UIKit

class MoviesCordinator: Coordinator {
    var children: [Coordinator] = []
    
    private let presenter: UIViewController
    private var navigationController: UINavigationController!

    private var subscriptions = Set<AnyCancellable>()

    init(presenter: UIViewController) {
        self.presenter = presenter
    }

    func start() {
        let builder = MoviesSceneBuilder()
        let viewController = builder.build()
        viewController.viewModelInput.menuTappedPublisher
            .sink { [weak self] in
                self?.showMenu()
            }.store(in: &subscriptions)
        
        viewController.viewModel.output.movieSelectedPublisher
            .sink { [weak self] movieData in
                guard let id = movieData.id else { return }
                self?.cordinateToMovieDetails(movieId: id)
            }.store(in: &subscriptions)
        
        navigationController = UINavigationController(rootViewController: viewController)
        navigationController.modalPresentationStyle = .fullScreen
        navigationController.modalTransitionStyle = .crossDissolve
        navigationController.isNavigationBarHidden = false
        presenter.present(navigationController, animated: true)
    }

    // MARK: - Flow Methods

    func showMenu() {
       let alert =  UIAlertController(title: "", message: "What do you want to do?", preferredStyle: .actionSheet)
        alert.addAction(.init(title: "View Profile", style: .default, handler: { action in
            self.cordinateToProfile()
        }))
        
        alert.addAction(.init(title: "LogOut", style: .destructive, handler: { action in
            self.cordinateToParent()
        }))
        
        alert.addAction(.init(title: "Cancel", style: .cancel, handler: nil))
        
        navigationController.present(alert, animated: true)
    }
    
    func cordinateToProfile() {
        let cor = ProfileCordinator(presenter: navigationController)
        coordinate(to: cor)
    }
    
    func cordinateToMovieDetails(movieId: Int) {
        let cor = MovieDetailCordinator(presenter: navigationController, movieId: movieId)
        coordinate(to: cor)
    }
    
    func cordinateToParent() {
        presenter.dismiss(animated: true)
    }
 
}
