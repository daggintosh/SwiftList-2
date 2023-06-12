//
//  swiftlist2App.swift
//  swiftlist2
//
//  Created by Dagg on 6/11/23.
//

import SwiftUI

@main
struct swiftlist2App: App {
    var body: some Scene {
        var initialFeed: [ListingChild] = []
        
        WindowGroup {
            TabView {
                Text("Hello, world").tabItem {
                    VStack {
                        Image(systemName: "star.fill")
                        Text("Test")
                    }
                }
                Home().tabItem {
                    VStack {
                        Image(systemName: "house.fill")
                        Text("Home")
                    }
                }
            }
        }
    }
}
