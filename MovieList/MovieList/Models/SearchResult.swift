//
//  SearchResult.swift
//  MovieList
//
//  Created by Eugene Berezin on 12/8/19.
//  Copyright © 2019 Eugene Berezin. All rights reserved.
//

import Foundation

struct SearchResult: Codable {
    var page: Int?
    var total_results: Int?
    var total_pages: Int?
    let results: [Result]?
}

struct Result: Codable {
    let original_title: String?
    var vote_average: Float?
    var release_date: String?
    var overview: String?
    let poster_path: String?
    let backdrop_path: String?
}



