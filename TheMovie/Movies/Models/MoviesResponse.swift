//
//  MovieModel.swift
//  TheMovie
//
//  Created by Gerardo on 02/12/22.
//

import Foundation

struct MoviesResponse: Decodable{
    var page: Int
    var results: [MovieResponse]?
    var total_pages: Int?
    var total_results: Int?
}


struct MovieResponse: Codable {
    
    var adult: Bool?
    var backdrop_path: String?
    var belongs_to_collection: Belongs_to_collection?
    var genre_ids: [Int]?
    var id: Int?
    var original_language: String?
    var original_title: String?
    var overview: String?
    var popularity: Float?
    var poster_path: String?
    var release_date: String?
    var revenue: Int?
    var runtime: Int?
    var title: String?
    var video: Bool?
    var vote_average: Double?
    var vote_count: Int?
    var budget: Int?
    var genres: [Genres]?
    var homepage: String?
    var imdb_id: String?
    var production_companies: [Production_companies]?
    var production_countries: [Production_countries]?
    var status: String?
    var tagline: String?
    var spoken_languages: [Spoken_languages]?
    
}

struct Belongs_to_collection: Codable{
    
    var id: Int?
    var name: String?
    var poster_path: String?
    var backdrop_path: String?
}

struct Genres: Codable{
    
    var id: Int?
    var name: String?
}

struct Production_companies: Codable{
    
    var id: Int?
    var logo_path: String?
    var name: String?
    var origin_country: String?
}

struct Production_countries: Codable{
    
    var iso_3166_1: String?
    var name: String?
}

struct Spoken_languages: Codable{
    
    var english_name: String?
    var iso_639_1: String?
    var name: String?
    
}


/*
struct MovieResponse: Decodable{
    
    var adult: Bool?
    var backdrop_path: String?
    var genre_ids: [Int]?
    var id: Int?
    var original_language: String?
    var original_title: String?
    var overview: String?
    var popularity: Float?
    var poster_path: String?
    var release_date: String?
    var title: String?
    var video: Bool?
    var vote_average: Double?
    var vote_count: Int?
}
*/
