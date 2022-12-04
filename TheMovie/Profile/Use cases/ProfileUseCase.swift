//
//  MoviesUseCaseProtocol.swift
//  TheMovie
//
//  Created by Gerardo on 02/12/22.
//


import Combine
import Foundation

class ProfileUseCase: ProfileUseCaseProtocol {

    private var repository: ProfileRepositoryProtocol
        
    init(repository: ProfileRepositoryProtocol) {
        self.repository = repository
    }
    
    func getName() -> String {
        return repository.name
    }
    
    func saveName(name: String) {
        repository.name = name
    }
}
