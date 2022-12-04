//
//  MoviesViewModel.swift
//  TheMovie
//
//  Created by Gerardo on 02/12/22.
//

protocol MovieDetailViewModelProtocol {
    var output: MovieDetailViewModelOutput { get }
    func bind(input: MovieDetailViewModelInput) -> MovieDetailViewModelOutput
}
