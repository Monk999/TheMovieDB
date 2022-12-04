//
//  MoviesViewModel.swift
//  TheMovie
//
//  Created by Gerardo on 02/12/22.
//

protocol MoviesViewModelProtocol {
    var output: MoviesViewModelOutput { get }
    func bind(input: MoviesViewModelInput) -> MoviesViewModelOutput
}
