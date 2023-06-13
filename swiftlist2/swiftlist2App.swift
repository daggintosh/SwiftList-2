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
        WindowGroup {
            TabView {
                Home(title: "r/Popular").tabItem {
                    VStack {
                        Image(systemName: "star.fill")
                        Text("Popular")
                    }
                }
                Home(title: "r/catslivingandwell").tabItem {
                    VStack {
                        Image(systemName: "cat.fill")
                        Text("Cats")
                    }
                }
                Home(title: "r/videos").tabItem {
                    VStack {
                        Image(systemName: "play.rectangle.fill")
                        Text("Videos")
                    }
                }
                Home(title: "r/memes").tabItem {
                    VStack {
                        Image(systemName: "music.mic")
                        Text("Memes")
                    }
                }
            }
        }
    }
}
