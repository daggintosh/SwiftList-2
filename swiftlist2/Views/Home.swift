//
//  Home.swift
//  swiftlist2
//
//  Created by Dagg on 6/11/23.
//

import SwiftUI

struct Home: View {
    @State var posts: [ListingChild] = []
    @State var title: String
    
    var body: some View {
        PostList(posts: $posts, title: title)
    }
}

struct PostList: View {
    @Binding var posts: [ListingChild]
    @State var loaded: Bool = false
    @State var title: String
    @State var status: String?
    
    var body: some View {
        ZStack {
            NavigationStack {
                List(posts, id: \.data.id) { post in
                    let data = post.data
                    VStack {
                        ListProto(post: data)
                    }.listRowInsets(EdgeInsets()).listRowSeparator(.hidden)
                }.navigationTitle(title)
            }.listStyle(.plain).onAppear {
                if loaded {return}
                DispatchQueue.global(qos: .background).async {
                    var status: Int = 0
                    let posts = GetAPI(path: title != "Your Feed" ? title : "", status: &status)
                    DispatchQueue.main.async {
                        self.posts = posts
                        self.loaded = true
                        switch status {
                        case 403:
                            self.status = "This subreddit is locked.\nTry again another day."
                        case 429:
                            self.status = "Rate limited.\nWait a minute and try again."
                        default:
                            return
                        }
                    }
                }
            }
            ProgressView("Fetching Feed").opacity(loaded ? 0:1)
            if let status = status {
                VStack {
                    Image(systemName: "lock.fill").padding()
                    Text(status).multilineTextAlignment(.center)
                }.font(.title2).fontWeight(.semibold)
            }
        }
    }
}
