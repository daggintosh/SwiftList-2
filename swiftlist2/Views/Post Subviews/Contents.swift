//
//  Contents.swift
//  swiftlist2
//
//  Created by Dagg on 6/13/23.
//

import SwiftUI

struct Contents: View {
    let postDetails: ListingChildData
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(postDetails.title ?? "Removed").font(.headline).fontWeight(.bold)
            if let link_flair_text = postDetails.link_flair_text {
                NiceFlair(flairText: link_flair_text, backgroundColor: postDetails.link_flair_background_color ?? "")
            }
            Text(postDetails.selftext ?? "[removed]")
            if let media_metadata = postDetails.media_metadata {
                ForEach(media_metadata.map {$0.value}, id: \.p?.first?.u) { value in
                    ASIPlaceholder(width: value.p?.last?.x, height: value.p?.last?.y, url: URL(string: ((value.s?.u ?? value.p?.last?.u) ?? "")))
                }
            }
            if let post_hint = postDetails.post_hint {
                switch post_hint {
                case "image":
                    let source = postDetails.preview?.images?.first?.source
                    let largestPreview = postDetails.preview?.images?.first?.resolutions?.last
                    let possibleWidths = (source?.width ?? largestPreview?.width ?? postDetails.thumbnail_width ?? 1)
                    let possibleHeights = (source?.height ?? largestPreview?.height ?? postDetails.thumbnail_height ?? 1)
                    let possibleURL = (source?.url ?? largestPreview?.url ?? postDetails.url ?? "")
                    ASIPlaceholder(width: possibleWidths, height: possibleHeights, url: URL(string: possibleURL))
                default:
                    Text(.init(stringLiteral: "[\(postDetails.url ?? "")](\(postDetails.url ?? ""))")).lineLimit(4).truncationMode(.tail).padding(.bottom, 4)
                    if let thumbnail = postDetails.thumbnail {
                        if !["nsfw", "self", "spoiler", "default"].contains(postDetails.thumbnail) {
                            ASIPlaceholder(width: postDetails.thumbnail_width ?? 1, height: postDetails.thumbnail_height ?? 1, url: URL(string: thumbnail))
                        }
                    }
                }
            }
            Divider().frame(height: 2).overlay(.secondary).padding(.horizontal, -16).padding(.bottom, 8)
            HStack {
                Image(systemName: "hand.thumbsup.fill")
                Text(postDetails.ups?.formatted(.number) ?? "0")
                ProgressView(value: postDetails.upvote_ratio ?? 0.5).tint(.green)
                Text(postDetails.num_comments?.formatted(.number) ?? "0")
                Image(systemName: "message.fill")
            }
            Divider().frame(height: 2).overlay(.secondary).padding(.horizontal, -16).padding(.bottom, 8)
        }.padding(.horizontal, 16).padding(.vertical, 8)
    }
}
