//
//  Replies.swift
//  swiftlist2
//
//  Created by Dagg on 6/13/23.
//

import SwiftUI

struct Replies: View {
    let replies: ReplyList
    
    var body: some View {
        if let data = replies.data?.children {
            VStack(alignment: .leading) {
                ForEach(data, id: \.data.id) { reply in
                    if (reply.data.depth ?? 0 < 4) {
                        HStack {
                            Divider().frame(width: 2).overlay(.secondary).padding(.leading, 6)
                            if reply.kind != "more" {
                                Comment(comment: reply).padding(.horizontal, 4)
                            } else {
                                // TODO: Allow continuing
                                // https://oauth.reddit.com/comments/{postId}/{commentId}.json
                                Text("... and \(reply.data.count ?? 0) more")
                            }
                        }.fixedSize(horizontal: false, vertical: true)
                    }
                }
            }
        }
    }
}
