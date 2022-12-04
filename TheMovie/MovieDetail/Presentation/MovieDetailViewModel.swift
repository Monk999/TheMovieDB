//
//  MoviesViewModel.swift
//  TheMovie
//
//  Created by Gerardo on 02/12/22.
//

import UIKit
import Combine

final class MovieDetailViewModel: MovieDetailViewModelProtocol {
        
    var output: MovieDetailViewModelOutput = MovieDetailViewModelOutput()

    private var subscriptions = Set<AnyCancellable>()
    
    private let useCase: MovieDetailUseCaseProtocol

    private let favoriteUseCase: FavoritesUseCaseProtocol

    private let movieId: Int
    
    private var videos: [VideoResponse] = [] {
        didSet {
            output.videosLoadedPublisher.send(videos.compactMap({.init(model: $0)}))
        }
    }
    
    private var movie: MovieResponse? {
        didSet {
            guard let movie = movie else {
                return
            }

            output.detailLoadedPublisher.send(.init(model: movie))
        }
    }

    
    private var isFavorite: Bool = false {
        didSet {
            output.isFavoritePublisher.send(isFavorite)
        }
    }
    
    init(useCase: MovieDetailUseCaseProtocol, favoriteUseCase: FavoritesUseCaseProtocol, movieId: Int) {
        self.favoriteUseCase = favoriteUseCase
        self.movieId = movieId
        self.useCase = useCase
    }

    func bind(input: MovieDetailViewModelInput) -> MovieDetailViewModelOutput {
        
        input.videoSelectedPublisher.sink { [weak self] index in
            guard let self = self else { return }
            self.output.videoSelectedPublisher.send(self.videos[index])
        }.store(in: &subscriptions)
        
        
        input.viewDidLoadPublisher.sink { [weak self] in
            self?.loadDetails()
        }.store(in: &subscriptions)
        
        input.changeIsFavoritePublisher.sink { [weak self] isFavorite in
            guard let self = self,
                  let movie = self.movie
            else { return }
            
            isFavorite ?
            self.favoriteUseCase.addFavorite(movie: movie) :
            self.favoriteUseCase.removeFavorite(movie: movie)
            
            self.isFavorite = isFavorite
        }.store(in: &subscriptions)
        
        return output
    }
    
    private func loadDetails() {
        
        output.requestingDataPublisher.send()
        
        useCase.getDetail(movieId: movieId).sink { [weak self] result in
            
            if case .failure(_) = result {
                self?.output.requestErrorPublisher.send()
            }
        } receiveValue: { [weak self] response in
            guard let self = self else { return }
            self.movie = response
            self.isFavorite = self.favoriteUseCase.isFavorite(movie: response)
            self.getMovies()
        }.store(in: &subscriptions)
    }
    
    private func getMovies() {
       
        
        useCase.getMovies(movieId: movieId).sink { [weak self] result in
            
            if case .failure(_) = result {
                // send message
            }
        } receiveValue: { [weak self] response in
            guard let self = self else { return }
            self.videos = response.results ?? []
        }.store(in: &subscriptions)
        
    }
}
