//
//  ListProto.swift
//  swiftlist2
//
//  Created by Dagg on 6/12/23.
//

import SwiftUI

struct ListProto: View {
    var post: ListingChildData

    let allowSubTraversal: Bool
    
    @State var loaded: Bool = false
    @State var comments: [Listing] = []
    
    @Binding var tabBarStateRequest: Bool?
    
    var body: some View {
        ZStack {
            NavigationLink {
                Post(loaded: loaded, targetId: post.id, allowSubTraversal: allowSubTraversal, posts: $comments, keepLTest: $loaded, communalBoolean: $tabBarStateRequest)
            } label: {}.opacity(0)
            VStack(alignment: .leading) {
                PrettyDividerBottom()
                if (allowSubTraversal) {
                    Text(post.subreddit_name_prefixed ?? "r/reddit").font(.title3).fontWeight(.black)
                }
                HStack(alignment: .top) {
                    Text("u/" + (post.author ?? "[deleted]")).font(.footnote).fontWeight(.bold)
                    let creationDate: Date = Date(timeIntervalSince1970: post.created_utc ?? Date.now.timeIntervalSince1970)
                    Text(""+RelativeDateTimeFormatter().localizedString(for: creationDate, relativeTo: Date.now)).font(.footnote).fontWeight(.light)
                    if post.edited?.isEdited ?? false {
                        Text("(edited)").font(.footnote).fontWeight(.light).padding(.bottom, 4)
                    }
                }
                Text(post.title ?? "Blam!").fontWeight(.heavy).lineLimit(2)
                if let link_flair_text = post.link_flair_text {
                    NiceFlair(flairText: link_flair_text, backgroundColor: post.link_flair_background_color ?? "")
                }
                if let selftext = post.selftext {
                    Text(.init(stringLiteral: selftext)).lineLimit(4).truncationMode(.tail).padding(.bottom, 4)
                }
                if let post_hint = post.post_hint {
                    if post_hint == "link" {
                        Text(.init(stringLiteral: "[\(post.url ?? "")](\(post.url ?? ""))")).lineLimit(4).truncationMode(.tail).padding(.bottom, 4)
                    }
                }
                if let thumbnail = post.thumbnail {
                    let newThumb = LowestThumb(post: post, thumbnail: thumbnail)
                    if !["nsfw", "self", "spoiler", "default", ""].contains(thumbnail) {
                        let media_metadata = post.media_metadata?.first?.value.p?.last
                        let preview = post.preview?.images?.first?.resolutions?.first
                        let newThumbX: Float = media_metadata?.x ?? preview?.width ?? post.thumbnail_width ?? 1
                        let newThumbY: Float = media_metadata?.y ?? preview?.height ?? post.thumbnail_height ?? 1
                        ASIPlaceholder(width: newThumbX, height: newThumbY, url: URL(string: (newThumb)))
                    }
                }
                HStack(alignment: .top) {
                    VStack(alignment:.leading) {
                        HStack {
                            Image(systemName: "hand.thumbsup.fill").foregroundColor(.accentColor)
                            Text(""+(post.ups ?? 0).formatted(.number))
                        }
                        ProgressView(value: post.upvote_ratio ?? 0.5).tint(.green)
                    }.fixedSize()
                    Spacer()
                    Text(""+(post.num_comments ?? 0).formatted(.number))
                    Image(systemName: "message.fill").foregroundColor(.accentColor)
                }.font(.callout).fontWeight(.bold).padding(.bottom, 8)
            }.padding(.horizontal, 16)
        }
    }
}
