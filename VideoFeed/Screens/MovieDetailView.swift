//
//  MovieDetailView.swift
//  VideoFeed
//
//  Created by DFAdmin on 28/07/24.
//

import Foundation
import SwiftUI
import CoreMotion

struct MovieDetailView: View {

    @EnvironmentObject
    var favorites: Favorites

    let movie: Movie

    var body: some View {
        contentView
            .navigationTitle("Movie Detail")
    }
}

extension MovieDetailView {

    var contentView: some View {
        ScrollView {
            VStack(alignment: .leading) {

                if let imageURL = URL(string: movie.image.iconicImage169) {
                    ParallaxImageView(imageURL: imageURL)
                        .frame(height: 300)
                        .clipped()
                } else {
                    Rectangle()
                        .fill(Color.gray)
                        .frame(height: 300)
                        .clipped()
                }

                VStack(alignment: .leading, spacing: 4) {
                    Text(movie.title)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)

                    HStack {
                        Text(movie.formattedDuration)
                        Text("•")
                        Text(movie.year)
                        Text("•")
                        Text(movie.rating)
                    }
                    .font(.subheadline)
                    .foregroundColor(.white)
                }
                .padding()
                .background(Color.red)
                .cornerRadius(10)
                .shadow(radius: 5)
                .padding()

                // Favourite Button
                favouriteButtonView
                    .padding()

                // Description
                Text(movie.longDescription)
                    .font(.body)
                    .padding()
            }
            .edgesIgnoringSafeArea(.top)
        }
    }
}


// MARK: - Content View

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailView(
            movie: .preview
        )
    }
}

extension Movie {

    var formattedDuration: String {
        let hours = duration / 3600
        let minutes = (duration % 3600) / 60

        if hours > 0 {
            return "\(hours) hr \(minutes) min"
        } else {
            return "\(minutes) min"
        }
    }
}

struct ParallaxImageView: View {
    var imageURL: URL
    @State private var offset: CGFloat = 0

    var body: some View {
        GeometryReader { geometry in
            AsyncImage(url: imageURL) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .offset(y: offset)
            } placeholder: {
                Rectangle()
                    .fill(Color.gray)
                    .frame(width: geometry.size.width, height: geometry.size.height)
            }
            .onAppear {
                let motionManager = CMMotionManager()
                if motionManager.isDeviceMotionAvailable {
                    motionManager.deviceMotionUpdateInterval = 0.02
                    motionManager.startDeviceMotionUpdates(to: .main) { (data, error) in
                        if let data = data {
                            let pitch = data.attitude.pitch
                            self.offset = CGFloat(pitch * 200)
                        }
                    }
                }
            }
        }
    }
}

private extension MovieDetailView {

    @ViewBuilder
    private var favouriteButtonView: some View  {
        Button(action: {
            favorites.toggleFavorite(movie)
        }) {
            HStack {
                Image(systemName: favorites.isFavorited(movie) ? "heart.fill" : "heart")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .foregroundColor(favorites.isFavorited(movie) ? .yellow : .black)
                Text(favorites.isFavorited(movie) ? "Favorited" : "Favorite")
                    .foregroundColor(.black)
            }
            .padding(8)
            .background(Color.white)
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.black, lineWidth: 1)
            )
        }
    }
}
