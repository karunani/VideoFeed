//
//  Favorites.swift
//  VideoFeed
//
//  Created by DFAdmin on 28/07/24.
//

import Foundation
import SwiftUI

class Favorites: ObservableObject {

    @AppStorage("favoritedMovieIDs")
    private var favoritedMovieIDsData: Data = Data()

    @Published var favoritedMovieIDs: Set<Int> = [] {
        didSet {
            saveFavorites()
        }
    }

    init() {
        loadFavorites()
    }

    func add(_ movie: Movie) {
        favoritedMovieIDs.insert(movie.id)
    }

    func remove(_ movie: Movie) {
        favoritedMovieIDs.remove(movie.id)
    }

    func isFavorited(_ movie: Movie) -> Bool {
        favoritedMovieIDs.contains(movie.id)
    }

    func toggleFavorite(_ movie: Movie) {
        if isFavorited(movie) {
            remove(movie)
        } else {
            add(movie)
        }
    }

    private func saveFavorites() {
        if let data = try? JSONEncoder().encode(favoritedMovieIDs) {
            favoritedMovieIDsData = data
        }
    }

    private func loadFavorites() {
        if let decoded = try? JSONDecoder().decode(Set<Int>.self, from: favoritedMovieIDsData) {
            favoritedMovieIDs = decoded
        }
    }
}
