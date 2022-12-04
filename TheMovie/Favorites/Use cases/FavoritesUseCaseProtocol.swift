//
//  FavoritesUseCaseProtocol.swift
//  TheMovie
//
//  Created by Gerardo on 03/12/22.
//

import Foundation


protocol FavoritesUseCaseProtocol {
    func isFavorite(movie: MovieResponse) -> Bool
    func addFavorite(movie: MovieResponse)
    func removeFavorite(movie: MovieResponse)
    func getFavorites() -> [MovieResponse]

}
