//
//  MovieModelView.swift
//  TheMovie
//
//  Created by Gerardo on 02/12/22.
//

import Foundation

struct MovieModelView {
    
    let title: String
    let date: String
    let rating: String
    let description: String
    let isFavorite: Bool
    let imageUrl: String


    init(model: MovieResponse, isFavorite: Bool) {
        self.isFavorite = isFavorite
        self.title = model.title ?? ""
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        if let date = formatter.date(from: model.release_date ?? "")
        {
            let outFormatter = DateFormatter()
            outFormatter.dateFormat = "MMM dd, yyyy"
            self.date = outFormatter.string(from: date)
        } else {
            self.date = ""
        }
            
        self.rating = "⭐️ " + String(format: "%.1f", model.vote_average ?? 0)
        self.description = model.overview ?? ""
        imageUrl =  APIConstants.imagePath + (model.poster_path ?? "") 
    }
}
