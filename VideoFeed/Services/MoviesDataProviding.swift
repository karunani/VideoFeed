//
//  MoviesDataProviding.swift
//  VideoFeed
//
//  Created by DFAdmin on 24/07/24.
//

import Foundation

/// Conforming type responsible to provide photos.
protocol MoviesDataProviding {
    
    func fetchMovies(completion: @escaping (Result<[Movie], Error>) -> Void)
    
}
