//
//  VideoFeedApp.swift
//  VideoFeed
//
//  Created by DFAdmin on 24/07/24.
//

import SwiftUI

@main
struct VideoFeedApp: App {

    // MARK: - StateObject
    @StateObject
    var favorites = Favorites()

    // MARK: - Body

    var body: some Scene {
        WindowGroup {
            NavigationView {
                MoviesHomeView()
                    .navigationBarHidden(true)
                    .environmentObject(favorites)
            }
        }
    }

    // MARK: - Initializers

    init() {
        let appearance = UINavigationBar.appearance()
        appearance.backgroundColor = .white
        appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
    }
}
