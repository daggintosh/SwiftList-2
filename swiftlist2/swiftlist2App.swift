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
            MainView()
        }
    }
}

struct MainView: View {
    @State var hiddenTabBar = false
    
    var body: some View {
        withAnimation {
            TabView() {
                Home(title: "Your Feed").tabItem {
                    VStack {
                        Image(systemName: "house.fill")
                        Text("Home").fontWeight(.bold)
                    }
                } // TODO: If user isn't signed in, don't show them this as the feed automatically fetches /r/Popular
                Home(title: "r/popular").tabItem {
                    VStack {
                        Image(systemName: "star.fill")
                        Text("Popular").fontWeight(.bold)
                    }
                }
                Search().tabItem {
                    VStack {
                        Image(systemName: "magnifyingglass")
                        Text("Search").fontWeight(.bold)
                    }
                }
                Text("Your account menu.").tabItem {
                    VStack {
                        Image(systemName: "person.fill")
                        Text("Account").fontWeight(.bold)
                    }
                }
            }.onAppear {
                let item = UITabBarItemAppearance()
                item.normal.iconColor = UIColor.label
                item.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.label]
                
                let app = UITabBarAppearance()
                app.stackedLayoutAppearance = item
                
                UITabBar.appearance().standardAppearance = app
                
                let audioSession = AVAudioSession.sharedInstance()
                do {
                    try? audioSession.setCategory(.playback)
                    try? audioSession.setActive(true)
                }
            }
        }
    }
}
