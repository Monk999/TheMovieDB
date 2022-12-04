//
//  MoviesViewModel.swift
//  TheMovie
//
//  Created by Gerardo on 02/12/22.
//

import UIKit
import Combine

final class MoviesViewModel: MoviesViewModelProtocol {
        
    var output: MoviesViewModelOutput = MoviesViewModelOutput()

    private var subscriptions = Set<AnyCancellable>()
    
    private let useCase: MoviesUseCaseProtocol
    
    private let favoriteUseCase: FavoritesUseCaseProtocol

    private var movies: [MovieResponse] = []
    
    private var selectedSection: Int = 0 {
        didSet {
            loadCurrentSection()
        }
    }

    init(useCase: MoviesUseCaseProtocol, favoriteUseCase: FavoritesUseCaseProtocol) {
        self.favoriteUseCase = favoriteUseCase
        self.useCase = useCase
    }

    func bind(input: MoviesViewModelInput) -> MoviesViewModelOutput {
        
        input.viewDidLoadPublisher.sink { [weak self] in
            self?.selectedSection = 0
        }.store(in: &subscriptions)
        
        input.viewWillAppearPublisher.sink { [weak self] in
            self?.sendViewModels()
        }.store(in: &subscriptions)
        
        input.sectionChangedPublisher.sink { [weak self] section in
            self?.selectedSection = section
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
    
    private func loadCurrentSection() {
        movies = []
        sendViewModels()
        guard let section  = MovieCategory(rawValue: selectedSection) else {
            return
        }
        
        output.requestingDataPublisher.send()
        
        useCase.getMovies(category: section, page: 1).sink { [weak self] result in
            
            if case .failure(_) = result {
                self?.output.requestErrorPublisher.send()
            }
        } receiveValue: { [weak self] data in
            self?.movies = data.results?.compactMap({$0}) ?? []
            self?.sendViewModels()
        }.store(in: &subscriptions)
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
