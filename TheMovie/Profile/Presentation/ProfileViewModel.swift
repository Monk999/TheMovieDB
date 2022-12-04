//
//  MoviesViewModel.swift
//  TheMovie
//
//  Created by Gerardo on 02/12/22.
//

import UIKit
import Combine

final class ProfileViewModel: ProfileViewModelProtocol {
        
    var output: ProfileViewModelOutput = ProfileViewModelOutput()

    private var subscriptions = Set<AnyCancellable>()
    
    private let useCase: ProfileUseCaseProtocol
    
    private let favoriteUseCase: FavoritesUseCaseProtocol

    private var movies: [MovieResponse] = []
    
    private var userName: String = "" {
        didSet {
            output.nameLoadedPublisher.send(userName)
        }
    }

    init(useCase: ProfileUseCaseProtocol, favoriteUseCase: FavoritesUseCaseProtocol) {
        self.favoriteUseCase = favoriteUseCase
        self.useCase = useCase
    }

    func bind(input: ProfileViewModelInput) -> ProfileViewModelOutput {
        
        input.viewDidLoadPublisher.sink { [weak self] in
            self?.loadData()
        }.store(in: &subscriptions)
        
        input.viewWillAppearPublisher.sink { [weak self] in
            self?.reloadFavorites()
        }.store(in: &subscriptions)
        
        input.changeIsFavoritePublisher.sink { [weak self] params in
            guard let self = self else { return }
            let movie = self.movies[params.index]
            
            params.isFavorite ?
            self.favoriteUseCase.addFavorite(movie: movie) :
            self.favoriteUseCase.removeFavorite(movie: movie)
            self.sendViewModels()
            
        }.store(in: &subscriptions)
        
        input.movieSelectedPublisher.sink { [weak self] index in
            guard let self = self else { return }
            self.output.movieSelectedPublisher.send(self.movies[index])
        }.store(in: &subscriptions)
        return output
    }
    
    private func reloadFavorites() {
        movies = favoriteUseCase.getFavorites()
        sendViewModels()
        userName = useCase.getName()
    }
    
    private func loadData() {
        sendViewModels()
    }
    
    private func sendViewModels() {
        var viewModels: [MovieModelView] = []
        for movie in movies {
            let isFavorite = self.favoriteUseCase.isFavorite(movie: movie)
            viewModels.append(MovieModelView.init(model: movie, isFavorite: isFavorite))
        }
        output.moviesLoadedPublisher.send(viewModels)
    }
}
