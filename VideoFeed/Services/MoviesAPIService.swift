//
//  MoviesService.swift
//  VideoFeed
//
//  Created by DFAdmin on 24/07/24.
//

import Foundation

/// Service responsible for fetching movies list from Server
final class MoviesAPIService {
    
    // MARK: - Private Properties
    
    private let session: URLSession
    private let urlString = ""
    private let decoder = JSONDecoder()
    
    // MARK: - Initializers
    
    init(session: URLSession = .shared) {
        self.session = session
    }
}


extension MoviesAPIService: MoviesDataProviding {
    
    // MARK: - Internal Methods
    
    func fetchMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            return
        }
        
        let dataTask = session.dataTask(with: url) { (data, response, error) in
            if let error {
                completion(.failure(error))
                return
            }
            
            guard let data else {
                completion(.failure(NSError(domain: "", code: 1000, userInfo: nil)))
                return
            }
            
            do {
                let movies = try self.decoder.decode([Movie].self, from: data)
                completion(.success(movies))
            } catch {
                completion(.failure(error))
            }
        }
        
        dataTask.resume()
    }
    
}
