//
//  MoviesViewModel.swift
//  TheMovie
//
//  Created by Gerardo on 02/12/22.
//

protocol ProfileViewModelProtocol {
    var output: ProfileViewModelOutput { get }
    func bind(input: ProfileViewModelInput) -> ProfileViewModelOutput
}
