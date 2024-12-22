//
//  MockMoviesServiceProvider.swift
//  VideoFeed
//
//  Created by DFAdmin on 24/07/24.
//

import Foundation

class MockMoviesService: MoviesDataProviding {
        
    func fetchMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        do {
            if let bundlePath = Bundle.main.path(forResource: "movies", ofType: "json"),
               let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                let mockData: Movies = try! JSONDecoder().decode(Movies.self, from: jsonData)
                completion(.success(mockData.movies))
            }
        } catch {
            completion(.failure(error))
        }
    }
    
}
