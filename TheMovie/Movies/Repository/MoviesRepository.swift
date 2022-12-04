//
//  MoviesRepository.swift
//  TheMovie
//
//  Created by Gerardo on 02/12/22.
//

import Foundation
import Combine



class MoviesRepository: MoviesRepositoryProtocol {
    
    private let session = URLSession.shared
    
    public init() { }
    
    func getPopularMovies(page: Int) -> AnyPublisher< MoviesResponse, Error> {
        return requestMovies(url: APIConstants.popularMoviesEndpoint + APIConstants.api_key + "&language=en-US&page=\(page)")
    }
    
    
    func getTopRatedMovies(page: Int) -> AnyPublisher< MoviesResponse, Error> {
        return requestMovies(url: APIConstants.topRatedMoviesEndpoint + APIConstants.api_key + "&language=en-US&page=\(page)")
    }
    
    func getNowPlayingMovies(page: Int) -> AnyPublisher< MoviesResponse, Error> {
        return requestMovies(url: APIConstants.nowPlayingMoviesEndpoint + APIConstants.api_key + "&language=en-US&page=\(page)")
    }
    
    func getUpcomingMovies(page: Int) -> AnyPublisher< MoviesResponse, Error> {
        return requestMovies(url: APIConstants.upcomingMoviesEndpoint + APIConstants.api_key + "&language=en-US&page=\(page)")
    }
    
    private func requestMovies(url urlS: String) -> AnyPublisher< MoviesResponse, Error> {
        let url = URL(string: urlS)!
        
        return session.dataTaskPublisher(for: url)
            .tryMap() { element -> Data in
                guard let httpResponse = element.response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return element.data
            }
            .decode(type: MoviesResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
   
}
