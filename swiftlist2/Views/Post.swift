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
    
    let allowSubTraversal: Bool
    
    @Binding var posts: [Listing]
    @Binding var keepLTest: Bool
    
    @Binding var tabBarStateRequest: Bool?
    
    @State var noNest: Bool = false
    
    var body: some View {
        ZStack {
            if posts.count == 2 {
                let post = posts[0].data.children[0].data
                List {
                    Group {
                        Contents(postDetails: post).padding(.bottom, 0).toolbar {
                            if (allowSubTraversal) {
                                Button {
                                    noNest = true
                                } label: {
                                    HStack {
                                        Text((post.subreddit_name_prefixed ?? "Private"))
                                        Image(systemName: "chevron.right").fontWeight(.semibold)
                                    }.fontWeight(.regular).font(.body).padding(.trailing, -8)
                                }.navigationDestination(isPresented: $noNest) {
                                    Home(title: post.subreddit_name_prefixed ?? "")
                                }
                            }
                        }
                        ForEach(posts[1].data.children, id: \.data.id) { comment in
                            if (comment.kind == "more") {
                                VStack(alignment: .center) {
                                    PrettyDivider()
                                    Text("...and \((comment.data.count ?? 0).formatted(.number)) more")
                                }
                            } else {
                                Comment(comment: comment)
                            }
                        }
                    }.listRowSeparator(.hidden)
                }.navigationBarTitleDisplayMode(.inline)
            }
            ProgressView("Fetching Comments").opacity(loaded ? 0:1)
            if let status = status {
                VStack {
                    Image(systemName: "lock.fill").padding()
                    Text(status).multilineTextAlignment(.center)
                }.font(.title2).fontWeight(.semibold)
            }
        }.onAppear {
            withAnimation {
                tabBarStateRequest = true
            }
            if loaded {return}
            DispatchQueue.global(qos: .background).async {
                var status: Int = 0
                let posts = GetAPI(id: targetId, status: &status)
                DispatchQueue.main.async {
                    self.posts = posts
                    self.keepLTest = true
                    self.loaded = true
                    self.status = Statuser(status: status)
                }
            }
        }.onDisappear {
            if !noNest {
                withAnimation {
                    tabBarStateRequest = false
                }
            }
        }
    }
}
