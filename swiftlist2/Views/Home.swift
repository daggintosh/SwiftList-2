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

    @State var hiddenTabBar: Bool = false
    @State var tabBarStateRequest: Bool? = false
    
    var body: some View {
        ZStack {
            NavigationStack {
                List(posts, id: \.data.id) { post in
                    let data = post.data
                    VStack {
                        ListProto(post: data, allowSubTraversal: title != "Your Feed" ? false : true, tabBarStateRequest: $tabBarStateRequest)
                    }.listRowInsets(EdgeInsets()).listRowSeparator(.hidden)
                }.navigationTitle(title)
            }.toolbar(hiddenTabBar ? .hidden : .visible, for: .tabBar).onChange(of: tabBarStateRequest, { oldValue, newValue in
                withAnimation {
                    hiddenTabBar = newValue ?? false
                }
            }).listStyle(.plain).onAppear {
                if loaded {return}
                DispatchQueue.global(qos: .background).async {
                    var status: Int = 0
                    // The title will be a prefixed subreddit
                    let posts = GetAPI(path: title != "Your Feed" ? title : "", status: &status)
                    DispatchQueue.main.async {
                        self.posts = posts
                        self.loaded = true
                        self.status = Statuser(status: status)
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
