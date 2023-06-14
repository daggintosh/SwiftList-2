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
                                VStack(alignment: .leading) {
                                    let data = reply.data
                                    HStack {
                                        Text("u/" + (data.author ?? "[deleted]")).font(.footnote).fontWeight(.bold)
                                        let creationDate: Date = Date(timeIntervalSince1970: data.created_utc ?? Date.now.timeIntervalSince1970)
                                        Text(""+RelativeDateTimeFormatter().localizedString(for: creationDate, relativeTo: Date.now)).font(.footnote).fontWeight(.light)
                                        if data.edited?.isEdited ?? false {
                                            Text("(edited)").font(.footnote).fontWeight(.light)
                                        }
                                    }
                                    Text(.init(stringLiteral: data.body ?? "[deleted]"))
                                    HStack {
                                        Image(systemName: "hand.thumbsup.fill")
                                        Text(data.ups?.formatted(.number) ?? "0")
                                    }
                                    if let replies = data.replies {
                                        Replies(replies: replies)
                                    }
                                }.padding(.leading, 2)
                            } else {
                                Text("... and \(reply.data.count ?? 0) more")
                            }
                        }.fixedSize(horizontal: false, vertical: true)
                    }
                }
            }
        }
    }
}
