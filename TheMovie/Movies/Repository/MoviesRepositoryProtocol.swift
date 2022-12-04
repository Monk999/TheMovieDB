//
//  MoviesRepositoryProtocol.swift
//  TheMovie
//
//  Created by Gerardo on 02/12/22.
//

import Foundation
import Combine


protocol MoviesRepositoryProtocol {
    func getPopularMovies(page: Int) ->  AnyPublisher<MoviesResponse, Error>
    func getTopRatedMovies(page: Int) -> AnyPublisher< MoviesResponse, Error>
    func getNowPlayingMovies(page: Int) -> AnyPublisher< MoviesResponse, Error>
    func getUpcomingMovies(page: Int) -> AnyPublisher< MoviesResponse, Error> 
}
