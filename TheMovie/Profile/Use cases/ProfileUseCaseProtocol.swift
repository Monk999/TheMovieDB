//
//  MoviesUseCaseProtocol.swift
//  TheMovie
//
//  Created by Gerardo on 02/12/22.
//


import Combine
import Foundation

protocol ProfileUseCaseProtocol {
    func getName() -> String
    func saveName(name: String) 
}
