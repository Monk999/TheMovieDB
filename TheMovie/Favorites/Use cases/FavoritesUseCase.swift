//
//  FavoritesUseCaseProtocol.swift
//  TheMovie
//
//  Created by Gerardo on 03/12/22.
//

import Foundation
import Combine

class FavoritesUseCase: FavoritesUseCaseProtocol {
    
    private let repository: FavoritesRepositoryProtocol

    private var subscriptions = Set<AnyCancellable>()
    
    init(repository: FavoritesRepositoryProtocol) {
        self.repository = repository
    }
    
    func isFavorite(movie: MovieResponse) -> Bool {
        return repository.isFavorite(movie: movie)
    }
    
    func addFavorite(movie: MovieResponse) {
        repository.addFavorite(movie: movie)
    }
    func removeFavorite(movie: MovieResponse) {
        repository.deleteFavorite(movie: movie)
    }
    
    func getFavorites() -> [MovieResponse] {
        return repository.getFavorites()
    }
}
