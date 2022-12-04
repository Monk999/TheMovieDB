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
    
    private let navigationController: UINavigationController
    private var currentNavigationController: UINavigationController!

    private var subscriptions = Set<AnyCancellable>()

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
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
        
        currentNavigationController = UINavigationController(rootViewController: viewController)
        currentNavigationController.modalPresentationStyle = .fullScreen
        currentNavigationController.modalTransitionStyle = .crossDissolve
        currentNavigationController.isNavigationBarHidden = false
        navigationController.present(currentNavigationController, animated: true)
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
        
        currentNavigationController.present(alert, animated: true)
    }
    
    func cordinateToProfile() {
        let cor = ProfileCordinator(navigationController: currentNavigationController)
        coordinate(to: cor)
    }
    
    func cordinateToMovieDetails(movieId: Int) {
        let cor = MovieDetailCordinator(navigationController: currentNavigationController, movieId: movieId)
        coordinate(to: cor)
    }
    
    func cordinateToParent() {
        currentNavigationController.dismiss(animated: true)
    }
 
}
