//
//  MoviesHomeView.swift
//  VideoFeed
//
//  Created by DFAdmin on 24/07/24.
//

import SwiftUI

struct MoviesHomeView: View {

    @EnvironmentObject
    var favorites: Favorites

    @ObservedObject
    private var viewModel = MovieListViewModel()

    private let layoutProvider = LayoutProvider()

    var body: some View {
        NavigationSplitView {
            contentView
                .navigationTitle("Movies")
                .onAppear {
                    viewModel.load()
                }
        } detail: {
            Text("Select a Movie")
        }
    }
    
    private var contentView: some View {
        ScrollView {
            LazyVGrid(columns: layoutProvider.columns) {
                ForEach(viewModel.movies) { movie in
                    NavigationLink(
                        destination: MovieDetailView(movie: movie)
                    ) {
                        MovieItemView(movie: movie)
                    }
                }
            }
        }
    }
}

struct MoviesHomeView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesHomeView()
    }
}

