//
//  Post.swift
//  swiftlist2
//
//  Created by Dagg on 6/12/23.
//

import SwiftUI

class PostModel: ObservableObject {
    @Published var data: [Listing] = []
}

struct Post: View {
    @State var loaded: Bool = false
    @State var status: String?
    var targetId: String
    
    @ObservedObject var model = PostModel()
    
    var body: some View {
        ZStack {
            List {
                if model.data.count == 2 {
                    let post = model.data[0].data.children[0].data
                    Text((post.title ?? "Removed")).toolbar {
                        Button {
                            
                        } label: {
                            Text((post.subreddit_name_prefixed ?? "Private"))
                        }
                    }
                    ForEach(model.data[1].data.children, id: \.data.id) { comment in
                        Comment(comment: comment)
                    }
//                    Text(.init(stringLiteral: model.data[0].data.children[0].data.title ?? "")).navigationTitle("u/" + (model.data[1].data.children[0].))
                }
            }.onAppear {
                if loaded {return}
                DispatchQueue.global(qos: .background).async {
                    var status: Int = 0
                    let posts = GetAPI(id: targetId, status: &status)
                    DispatchQueue.main.async {
                        self.model.data = posts
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
