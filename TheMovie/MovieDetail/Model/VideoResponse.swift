//
//  MovieResponse.swift
//  TheMovie
//
//  Created by Gerardo on 03/12/22.
//

import Foundation

struct VideosResponse: Decodable {
    var id: Int?
    var results: [VideoResponse]?
}

struct VideoResponse: Decodable {
    var name: String?
    var key: String?
    var site: String?
}
