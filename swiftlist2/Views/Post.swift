//
//  Post.swift
//  swiftlist2
//
//  Created by Dagg on 6/12/23.
//

import SwiftUI

struct Post: View {
    @State var loaded: Bool
    @State var status: String?
    var targetId: String
    
    @Binding var posts: [Listing]
    @Binding var keepLTest: Bool
    
    var body: some View {
        ZStack {
            List {
                if posts.count == 2 {
                    let post = posts[0].data.children[0].data
                    Contents(postDetails: post).toolbar {
                        Button {
                            
                        } label: {
                            Text((post.subreddit_name_prefixed ?? "Private"))
                        }
                    }.listRowSeparator(.hidden).padding(.bottom, 0)
                    ForEach(posts[1].data.children, id: \.data.id) { comment in
                        if (comment.kind == "more") {
                            VStack(alignment: .center) {
                                PrettyDividerTop()
                                Text("...and \((comment.data.count ?? 0).formatted(.number)) more")
                            }
                        } else {
                            Comment(comment: comment)
                        }
                    }.listRowSeparator(.hidden)
                }
            }.navigationBarTitleDisplayMode(.inline).onAppear {
                if loaded {return}
                DispatchQueue.global(qos: .background).async {
                    var status: Int = 0
                    let posts = GetAPI(id: targetId, status: &status)
                    DispatchQueue.main.async {
                        self.posts = posts
                        self.keepLTest = true
                        self.loaded = true
                        switch status {
                        case 403:
                            self.status = "Forbidden.\nTry again another day."
                        case 429:
                            self.status = "Rate limited.\nWait a minute and try again."
                        default:
                            return
                        }
                    }
                }
            }
            ProgressView("Fetching Comments").opacity(loaded ? 0:1)
            if let status = status {
                VStack {
                    Image(systemName: "lock.fill").padding()
                    Text(status).multilineTextAlignment(.center)
                }.font(.title2).fontWeight(.semibold)
            }
        }
    }
}
