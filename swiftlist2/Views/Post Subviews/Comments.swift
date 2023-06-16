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
            let data = comment.data
            HStack {
                if let distinguished = data.distinguished {
                    if (distinguished == "moderator") {
                        NiceFlair(flairText: "u/" + (data.author ?? "[deleted]"), backgroundColor: "#00BB00").fontWeight(.black)
                    }
                } else {
                    Text("u/" + (data.author ?? "[deleted]")).fontWeight(.bold)
                }
                if let is_submitter = data.is_submitter {
                    if (is_submitter) {
                        NiceFlair(flairText: "OP", backgroundColor: "#00AAFF").fontWeight(.black)
                    }
                }
                let creationDate: Date = Date(timeIntervalSince1970: data.created_utc ?? Date.now.timeIntervalSince1970)
                Text(""+RelativeDateTimeFormatter().localizedString(for: creationDate, relativeTo: Date.now)).fontWeight(.light)
                if data.edited?.isEdited ?? false {
                    Text("(edited)").fontWeight(.light)
                }
            }.font(.footnote)
            if let media_metadata = data.media_metadata {
                SiftMediaMetadata(media_metadata: media_metadata).padding(.horizontal, -16)
            }
            Text(.init(stringLiteral: data.body?.replacingOccurrences(of: #"(https?:\/\/preview.redd.it.*?(\n\n|\z))|(\!\[gif\]\(.*\))"#, with: "", options: .regularExpression) ?? "[removed]")).font(.body)
            HStack(alignment: .bottom) {
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
