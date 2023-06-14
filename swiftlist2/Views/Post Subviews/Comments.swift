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
            Text(.init(stringLiteral: data.body ?? "[deleted]")).layoutPriority(2)
            HStack {
                Image(systemName: "hand.thumbsup.fill")
                Text(data.upvote_ratio?.formatted(.number) ?? "0")
            }
            if let replies = data.replies {
                Replies(replies: replies).layoutPriority(1)
            }
        }
    }
}
