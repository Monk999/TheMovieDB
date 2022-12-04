//
//  MoviesUseCaseProtocol.swift
//  TheMovie
//
//  Created by Gerardo on 02/12/22.
//


import Combine
import Foundation

protocol MovieDetailUseCaseProtocol {
    func getDetail(movieId: Int) ->  AnyPublisher<MovieResponse, Error>
    func getMovies(movieId: Int) ->  AnyPublisher<VideosResponse, Error>
}
