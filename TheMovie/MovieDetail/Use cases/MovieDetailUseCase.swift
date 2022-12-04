//
//  MoviesUseCaseProtocol.swift
//  TheMovie
//
//  Created by Gerardo on 02/12/22.
//


import Combine
import Foundation

class MovieDetailUseCase: MovieDetailUseCaseProtocol {

    private let repository: MovieDetailRepositoryProtocol
    
    private var subscriptions = Set<AnyCancellable>()
    
    init(repository: MovieDetailRepositoryProtocol) {
        self.repository = repository
    }
    
    func getDetail(movieId: Int) ->  AnyPublisher<MovieResponse, Error> {
        return repository.getDetail(movieId: movieId)
    }
    
    func getMovies(movieId: Int) ->  AnyPublisher<VideosResponse, Error> {
        return repository.getMovies(movieId: movieId)
    }

}
