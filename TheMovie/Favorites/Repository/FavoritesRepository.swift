//
//  MoviesRepository.swift
//  TheMovie
//
//  Created by Gerardo on 02/12/22.
//

import Foundation
import Combine



class FavoritesRepository: FavoritesRepositoryProtocol {
    

    private var FAVORITES_KEY = "favorites.json"
    private var favorites: [MovieResponse] {
        didSet {
            Storage.store(favorites, to: .documents, as: FAVORITES_KEY)
        }
    }
    
    static var shared = FavoritesRepository()
    
    private init() {
        if Storage.fileExists(FAVORITES_KEY, in: .documents) {
            favorites = Storage.retrieve(FAVORITES_KEY, from: .documents, as: [MovieResponse].self)
        } else {
            favorites = []
        }
    }
   
    func isFavorite(movie: MovieResponse) -> Bool {
        return favorites.contains(where: {$0.id == movie.id})
    }
    
    func addFavorite(movie: MovieResponse) {
        favorites.append(movie)
    }
    
    func deleteFavorite(movie: MovieResponse) {
        favorites.removeAll(where: {$0.id == movie.id})
    }
    
    func getFavorites() -> [MovieResponse] {
        return favorites
    }
}
