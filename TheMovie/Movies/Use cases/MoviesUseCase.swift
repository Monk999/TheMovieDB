//
//  MoviesUseCaseProtocol.swift
//  TheMovie
//
//  Created by Gerardo on 02/12/22.
//


import Combine
import Foundation

class MoviesUseCase: MoviesUseCaseProtocol {

    private let repository: MoviesRepositoryProtocol
    
    private var subscriptions = Set<AnyCancellable>()
    
    init(repository: MoviesRepositoryProtocol) {
        self.repository = repository
    }
    
    func getMovies(category: MovieCategory, page: Int) ->  AnyPublisher<MoviesResponse, Error> {
        switch category {
        case .popular:
            return repository.getPopularMovies(page: page)
        case .topRated:
            return repository.getTopRatedMovies(page: page)
        case .upcoming:
            return repository.getUpcomingMovies(page: page)
        case .nowPlaying:
            return repository.getNowPlayingMovies(page: page)
        }
    }
}
