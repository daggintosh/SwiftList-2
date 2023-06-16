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
                        Reply(reply: reply)
                    }
                }
            }
        }
    }
}

struct Reply: View {
    let reply: ListingChild
    
    var body: some View {
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
                    if let media_metadata = data.media_metadata {
                        SiftMediaMetadata(media_metadata: media_metadata)
                    }
                    Text(.init(stringLiteral: data.body?.replacingOccurrences(of: #"(https?:\/\/preview.redd.it.*?(\n\n|\z))|((\!\[gif\]|\!\[img\])\(.*\))"#, with: "", options: .regularExpression) ?? "[removed]"))
                    HStack {
                        Image(systemName: "hand.thumbsup.fill").foregroundColor(.accentColor)
                        Text(data.ups?.formatted(.number) ?? "0")
                        Spacer()
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
