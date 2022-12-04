//
//  MoviesRepositoryProtocol.swift
//  TheMovie
//
//  Created by Gerardo on 02/12/22.
//

import Foundation
import Combine


protocol FavoritesRepositoryProtocol {
    func isFavorite(movie: MovieResponse) -> Bool
    func addFavorite(movie: MovieResponse)
    func deleteFavorite(movie: MovieResponse)
    func getFavorites() -> [MovieResponse]
}
