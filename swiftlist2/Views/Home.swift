//
//  Home.swift
//  swiftlist2
//
//  Created by Dagg on 6/11/23.
//

import SwiftUI

class PostsModel: ObservableObject {
    @Published var posts: [ListingChild] = []
}

struct Home: View {
    @StateObject var model = PostsModel()
    
    var body: some View {
        PostList(model: model)
    }
}

struct PostList: View {
    @ObservedObject var model: PostsModel

    var body: some View {
        NavigationStack {
            List(model.posts, id: \.data.id) { post in
                let data = post.data
                NavigationLink {Text("t")} label: {
                    VStack {
                        HStack {
                            Text(data.author)
                            Spacer()
                            Text(data.subreddit_name_prefixed)
                        }
                        Text(data.title).fontWeight(.heavy)
                        if let selftext = data.selftext {Text(selftext)}
                    }
                }
            }.navigationTitle("r/Popular")
        }.listStyle(.plain).onAppear {
            DispatchQueue.global(qos: .background).async {
                let posts = GetFeed()
                DispatchQueue.main.async {
                    self.model.posts = posts
                }
            }
        }
    }
}
