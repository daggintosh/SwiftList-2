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
            HStack {
                Text("u/" + (postDetails.author ?? "[deleted]")).fontWeight(.bold)
                let creationDate: Date = Date(timeIntervalSince1970: postDetails.created_utc ?? Date.now.timeIntervalSince1970)
                Text(""+RelativeDateTimeFormatter().localizedString(for: creationDate, relativeTo: Date.now)).fontWeight(.light)
                if postDetails.edited?.isEdited ?? false {
                    Text("(edited)").fontWeight(.light)
                }
            }.font(.footnote)
            Text(postDetails.title ?? "Removed").font(.headline).fontWeight(.bold)
            if let link_flair_text = postDetails.link_flair_text, let link_flair_text_color = postDetails.link_flair_text_color, let link_flair_background_color = postDetails.link_flair_background_color {
                NiceFlair(flairText: link_flair_text, backgroundColor: link_flair_background_color, flairTextColor: link_flair_text_color)
            }
            Text(.init(stringLiteral: (postDetails.selftext ?? "[removed]"))).font(.body).fontWeight(.regular)
            if let media_metadata = postDetails.media_metadata {
                SiftMediaMetadata(media_metadata: media_metadata)
            }
            if let post_hint = postDetails.post_hint {
                let source = postDetails.preview?.images?.first?.source
                let largestPreview = postDetails.preview?.images?.first?.resolutions?.last
                let possibleWidths = (source?.width ?? largestPreview?.width ?? postDetails.thumbnail_width ?? 1)
                let possibleHeights = (source?.height ?? largestPreview?.height ?? postDetails.thumbnail_height ?? 1)
                let possibleURL = (source?.url ?? largestPreview?.url ?? postDetails.url ?? "")
                let override = URL(string: (postDetails.preview?.images?.first?.variants?.gif?.source?.url ?? ""))
                let gif = override != nil
                
                switch post_hint {
                case "hosted:video":
                    if let reddit_video = postDetails.secure_media?.reddit_video {
                        VideoView(url: URL(string: reddit_video.hls_url)).aspectRatio(Double((reddit_video.width ?? 1)/(reddit_video.height ?? 1)),contentMode: .fit).padding(.horizontal, -16).compositingGroup()
                    }
                case "image":
                    if (!gif) {
                        ASIPlaceholder(width: possibleWidths, height: possibleHeights, url: URL(string: possibleURL))
                    } else {
                        WebView(url: override).aspectRatio(Double(possibleWidths/possibleHeights), contentMode: .fit).padding(.horizontal, -16).compositingGroup()
                    }
                case "self":
                    EmptyView()
                default:
                    Text(.init(stringLiteral: "[\(postDetails.url ?? "")](\(postDetails.url ?? ""))")).font(.body)
                    if let secure_media = postDetails.secure_media?.oembed {
                        if secure_media.provider_url == "https://www.youtube.com/" {
                            if let url = extractYTVideoID(thumbnail_url: secure_media.thumbnail_url ?? "") {
                                WebView(url: url).aspectRatio(Double((secure_media.width ?? 1)/(secure_media.height ?? 1)),contentMode: .fit).padding(.horizontal, -16).compositingGroup()
                            }
                        } else {
                            // Not youtube, just embed the original normally
                            // TODO: This method is a lot cleaner, use it.
                            if let secure_media_embed = postDetails.secure_media_embed {
                                if let width = secure_media_embed.width, let height = secure_media_embed.height, let content = secure_media_embed.content {
                                    WebView(content: content).aspectRatio(width/height, contentMode: .fit).padding(.horizontal, -16).compositingGroup()
                                }
                            }
                        }
                    } else {
                        if let preview = postDetails.preview?.reddit_video_preview {
                            GifView(url: URL(string: preview.hls_url)).aspectRatio(Double((preview.width ?? 1)/(preview.height ?? 1)), contentMode: .fit).padding(.horizontal, -16).compositingGroup()
                        }
                        else if let thumbnail = postDetails.thumbnail {
                            if !["nsfw", "self", "spoiler", "default"].contains(thumbnail) {
                                ASIPlaceholder(width: possibleWidths, height: possibleHeights, url: URL(string: possibleURL))
                            }
                        }
                    }
                    
                    
                }
            }
            HStack(alignment: .top) {
                VStack {
                    HStack(alignment: .center) {
                        Image(systemName: "hand.thumbsup.fill").foregroundColor(.accentColor)
                        Text(postDetails.ups?.formatted(.number) ?? "0")
                    }
                    ProgressView(value: postDetails.upvote_ratio ?? 0.5).tint(.green)
                }.fixedSize()
                Spacer()
                HStack(alignment:.top) {
                    Text(postDetails.num_comments?.formatted(.number) ?? "0")
                    Image(systemName: "message.fill").foregroundColor(.accentColor)
                }.padding(.top, 0.75) // This seems like a bad idea, but it's fine for now
            }
            PrettyDivider()
        }
    }
}
