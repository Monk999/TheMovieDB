//
//  MovieModelView.swift
//  TheMovie
//
//  Created by Gerardo on 02/12/22.
//

import Foundation

struct CompanyModelView {
    let name: String
    let image: String
}

struct VideoModelView {
    let title: String

    init(model: VideoResponse) {
        title = model.name ?? ""
    }
}

struct MovieDetailModelView {
    
    let title: String
    let date: String
    let rating: String
    let description: String
    let status: String
    let originaLanguage: String
    let homepage: String
    let companies: [CompanyModelView]
    let imageUrl: String
    

    init(model: MovieResponse) {
        
        imageUrl =  APIConstants.imagePath + (model.poster_path ?? "")

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
        self.status = model.status ?? ""
        self.originaLanguage = model.original_language ?? ""
        self.homepage = model.homepage ?? ""
        self.companies = model.production_companies?
            .compactMap( {
                CompanyModelView(
                    name: $0.name ?? "",
                    image:  APIConstants.imagePath + ( $0.logo_path ?? "")) })
        ?? []
    }
}
