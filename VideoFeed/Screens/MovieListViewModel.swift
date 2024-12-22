//
//  MovieListViewModel.swift
//  VideoFeed
//
//  Created by DFAdmin on 24/07/24.
//

import Foundation

class MovieListViewModel: ObservableObject {
    
    // MARK: - Internal Properties
    
    @Published
    var movies: [Movie] = []
    
    // MARK: - Private Properties
    
    private let dataProvider: MoviesDataProviding
    
    init(dataProvider: MoviesDataProviding = MockMoviesService()) {
        self.dataProvider = dataProvider
    }
    
    // MARK: - Internal Methods
    
    func load() {
        dataProvider.fetchMovies(completion: {  result in
            switch result {
            case .success(let movies):
                self.movies = movies
                
            case .failure(let error):
                print(error.localizedDescription) // Handle the error
            }
        })
    }
                                 
}
