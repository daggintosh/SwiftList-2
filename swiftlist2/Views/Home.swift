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
    @State var title: String
    
    var body: some View {
        PostList(model: model, title: title)
    }
}

struct PostList: View {
    @ObservedObject var model: PostsModel
    @State var loaded: Bool = false
    @State var title: String
    @State var status: String?
    
    var body: some View {
        ZStack {
            NavigationStack {
                List(model.posts, id: \.data.id) { post in
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
                        self.model.posts = posts
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
