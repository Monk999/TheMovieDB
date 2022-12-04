//
//  MoviesRepository.swift
//  TheMovie
//
//  Created by Gerardo on 02/12/22.
//

import Foundation
import Combine

class MovieDetailRepository: MovieDetailRepositoryProtocol {
    
    private let session = URLSession.shared
    
    public init() { }
    
    func getDetail(movieId: Int) ->  AnyPublisher<MovieResponse, Error> {

        let urlS = APIConstants.movieDetailEndpoint + "\(movieId)?api_key=\(APIConstants.api_key)&language=en-US"
                
        let url = URL(string: urlS)!
        
        return session.dataTaskPublisher(for: url)
            .tryMap() { element -> Data in
                guard let httpResponse = element.response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return element.data
            }
            .decode(type: MovieResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
   
    func getMovies(movieId: Int) ->  AnyPublisher<VideosResponse, Error> {
        
        let urlS = APIConstants.videosEndpoint + "\(movieId)/videos?api_key=\(APIConstants.api_key)&language=en-US"
                
        let url = URL(string: urlS)!
        
        return session.dataTaskPublisher(for: url)
            .tryMap() { element -> Data in
                guard let httpResponse = element.response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return element.data
            }
            .decode(type: VideosResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
}
