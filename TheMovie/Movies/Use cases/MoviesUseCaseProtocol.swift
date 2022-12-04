//
//  MoviesUseCaseProtocol.swift
//  TheMovie
//
//  Created by Gerardo on 02/12/22.
//


import Combine
import Foundation

enum MovieCategory: Int {
    case popular
    case topRated
    case upcoming
    case nowPlaying
}

protocol MoviesUseCaseProtocol {
    func getMovies(category: MovieCategory, page: Int) ->  AnyPublisher<MoviesResponse, Error>
}
