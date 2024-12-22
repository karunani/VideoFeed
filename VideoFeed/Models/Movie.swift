//
//  Movie.swift
//  VideoFeed
//
//  Created by DFAdmin on 24/07/24.
//

import Foundation

struct Movie: Decodable, Identifiable {
    let id: Int
    let title: String
    let longDescription: String
    let image: MovieImage
    let rating: String
    let year: String
    let duration: Int
    
    enum CodingKeys: String, CodingKey {
        case id = "contentId", title, longDescription, image, rating, year, duration
    }
}

struct MovieImage: Decodable {
    let image23: String
    let image169: String
    let iconicImage23: String
    let iconicImage169: String
}

struct Movies: Decodable {
    var movies: [Movie]

    enum RootKeys: String, CodingKey {
        case resultObj
    }

    enum ResultObjKeys: String, CodingKey {
        case movieContainers = "containers"
    }
    
    enum MetadataKeys: String, CodingKey {
        case metadata
    }
    
    enum MovieKeys: String, CodingKey {
        case contentId, title, longDescription, image23, image169, iconicImage23, iconicImage169, rating, year, duration
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: RootKeys.self)
        let resultObjContainer = try container.nestedContainer(keyedBy: ResultObjKeys.self, forKey: .resultObj)
                
        var unkeyedContainer = try resultObjContainer.nestedUnkeyedContainer(forKey: .movieContainers)

        var moviesArray = [Movie]()
        while !unkeyedContainer.isAtEnd {
            let metadataContainer = try unkeyedContainer.nestedContainer(keyedBy: MetadataKeys.self)
            
            let movieContainer = try metadataContainer.nestedContainer(keyedBy: MovieKeys.self, forKey: .metadata)

            let id = try movieContainer.decode(Int.self, forKey: .contentId)
            let title = try movieContainer.decode(String.self, forKey: .title)
            let longDescription = try movieContainer.decode(String.self, forKey: .longDescription)
            let image23 = try movieContainer.decode(String.self, forKey: .image23)
            let image169 = try movieContainer.decode(String.self, forKey: .image169)
            let iconicImage23 = try movieContainer.decode(String.self, forKey: .iconicImage23)
            let iconicImage169 = try movieContainer.decode(String.self, forKey: .iconicImage169)
            let rating = try movieContainer.decode(String.self, forKey: .rating)
            let year = try movieContainer.decode(String.self, forKey: .year)
            let duration = try movieContainer.decode(Int.self, forKey: .duration)

            let movie = Movie(id: id,
                              title: title,
                              longDescription: longDescription,
                              image: MovieImage(image23: image23,
                                                image169: image169,
                                                iconicImage23: iconicImage23,
                                                iconicImage169: iconicImage169),
                              rating: rating,
                              year: year,
                              duration: duration)
            moviesArray.append(movie)
        }
        self.movies = moviesArray
    }
}

