//
//  Comments.swift
//  swiftlist2
//
//  Created by Dagg on 6/13/23.
//

import SwiftUI

struct Comment: View {
    let comment: ListingChild
    
    var body: some View {
        VStack(alignment: .leading) {
            PrettyDividerTop()
            let data = comment.data
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
            Text(.init(stringLiteral: data.body?.replacingOccurrences(of: #"(https?:\/\/preview.redd.it.*?(\n\n|\z))|(\!\[gif\]\(.*\))"#, with: "", options: .regularExpression) ?? "[removed]"))
            HStack {
                Image(systemName: "hand.thumbsup.fill").foregroundColor(.accentColor)
                Text(data.ups?.formatted(.number) ?? "0")
                Spacer()
            }
            if let replies = data.replies {
                Replies(replies: replies).layoutPriority(1)
            }
        }
    }
}
