//
//  MovieItemView.swift
//  VideoFeed
//
//  Created by DFAdmin on 24/07/24.
//

import SwiftUI

struct MovieItemView: View {

    @EnvironmentObject
    var favorites: Favorites

    let movie: Movie

    var body: some View {
        contentView
    }
}

private extension MovieItemView {

    @ViewBuilder
    private var contentView: some View {
        VStack(alignment: .leading) {
            imageView
            metadataView
        }
        .background(BrandColor.white)
        .cornerRadius(10)
        .shadow(radius: 5)
        .padding([.leading, .trailing])
    }

    @ViewBuilder
    private var imageView: some View {
        VStack(alignment: .leading) {
            AsyncImage(url: URL(string: movie.image.image23)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth: .infinity)
                    .clipped()
            } placeholder: {
                Color.gray
                    .frame(maxWidth: .infinity, maxHeight: 200)
                    .cornerRadius(10)
            }
        }
    }

}

private extension MovieItemView {

    @ViewBuilder
    private var metadataView: some View {
        VStack(alignment: .leading, spacing: 4) {
            titleView
            descriptionView
        }
    }

    @ViewBuilder
    private var titleView: some View {
        Text(movie.title)
            .font(.headline)
            .lineLimit(2)
            .padding([.top, .leading, .trailing])
            .multilineTextAlignment(.leading)
    }

    @ViewBuilder
    private var descriptionView: some View {
        Text(movie.longDescription)
            .font(.subheadline)
            .lineLimit(3)
            .padding([.leading, .bottom, .trailing])
            .multilineTextAlignment(.leading)
    }
}


struct MovieItemView_Previews: PreviewProvider {
    static var previews: some View {
        MovieItemView(movie: Movie.preview)
            .previewLayout(.fixed(width: 170, height: 250))
    }
}


