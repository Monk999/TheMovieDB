//
//  MoviesRepositoryProtocol.swift
//  TheMovie
//
//  Created by Gerardo on 02/12/22.
//

import Foundation
import Combine


protocol MovieDetailRepositoryProtocol {
    func getDetail(movieId: Int) ->  AnyPublisher<MovieResponse, Error>
    func getMovies(movieId: Int) ->  AnyPublisher<VideosResponse, Error>
}
