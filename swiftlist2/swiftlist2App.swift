//
//  swiftlist2App.swift
//  swiftlist2
//
//  Created by Dagg on 6/11/23.
//

import SwiftUI
import AVFAudio

@main
struct swiftlist2App: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                Home(title: "Your Feed").tabItem {
                    VStack {
                        Image(systemName: "house.fill")
                        Text("Home")
                    }
                } // TODO: If user isn't signed in, don't show them this as the feed automatically fetches /r/Popular
                Home(title: "r/popular").tabItem {
                    VStack {
                        Image(systemName: "star.fill")
                        Text("Popular")
                    }
                }
                Text("Your account menu.").tabItem {
                    VStack {
                        Image(systemName: "person.fill")
                        Text("Account")
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
                
            }.onAppear {
                let audioSession = AVAudioSession.sharedInstance()
                do {
                    try? audioSession.setCategory(.playback)
                    try? audioSession.setActive(true)
                }
            }
        }
    }
}
