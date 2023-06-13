//
//  ListProto.swift
//  swiftlist2
//
//  Created by Dagg on 6/12/23.
//

import SwiftUI

struct ListProto: View {
    var post: ListingChildData
    
    var body: some View {
        ZStack {
            NavigationLink {Post(targetId: post.id)} label: {}.opacity(0)
            VStack(alignment: .leading) {
                Divider().frame(height: 2).overlay(.secondary).padding(.horizontal, -16).padding(.bottom, 8)
                HStack(alignment: .top) {
                    VStack(alignment: .leading) {
                        Text(post.subreddit_name_prefixed).font(.footnote)
                        let creationDate: Date = Date(timeIntervalSince1970: post.created_utc)
                        Text(""+RelativeDateTimeFormatter().localizedString(for: creationDate, relativeTo: Date.now)).font(.footnote).fontWeight(.light)
                    }
                    Spacer()
                    VStack(alignment: .trailing) {
                        Text("u/" + post.author).font(.footnote)
                        if post.edited.isEdited {Text("(edited)").font(.footnote).fontWeight(.light)}
                    }
                }.padding(.bottom, 4)
                Text(post.title).fontWeight(.heavy).lineLimit(2)
                if let link_flair_text = post.link_flair_text {
                    var out: Color = .white
                    ZStack {
                        Rectangle().overlay(hexToColor(str: post.link_flair_background_color!, out: &out)).cornerRadius(10)
                        Text(""+link_flair_text).font(.caption).fontWeight(.semibold).foregroundColor(out).padding(4)
                    }.fixedSize()
                }
                if let selftext = post.selftext {Text(.init(stringLiteral: selftext)).lineLimit(4).truncationMode(.tail)}
                if let thumbnail = post.thumbnail {
                    let newThumb = split(post: post, thumbnail: thumbnail)
                    if !["nsfw", "self", "spoiler", "default"].contains(thumbnail) {
                        AsyncImage(url: URL(string: newThumb)) { Image in
                            Image.resizable().aspectRatio(contentMode: .fit)
                        } placeholder: {
                            ZStack {
                                if let thumbnail_width = post.thumbnail_width, let thumbnail_height = post.thumbnail_height {
                                    let media_metadata = post.media_metadata?.first?.value.p?.last
                                    let preview = post.preview?.images?.first?.resolutions?.first
                                    let newThumbX: Float = media_metadata?.x ?? preview?.width ?? thumbnail_width
                                    let newThumbY: Float = media_metadata?.y ?? preview?.height ?? thumbnail_height
                                    let ratio : Double = Double(newThumbX/newThumbY)
                                    Rectangle().fill(.black).aspectRatio(ratio, contentMode: .fit)
                                }
                                else {
                                    Rectangle().fill(.black).aspectRatio(1/1, contentMode: .fit)
                                }
                                ProgressView().tint(.white)
                            }
                        }.padding(.horizontal, -16).padding(.bottom, 8)
                    }
                }
                HStack(alignment: .top) {
                    VStack(alignment:.leading) {
                        HStack {
                            Image(systemName: "hand.thumbsup.fill")
                            Text(""+post.ups.formatted(.number))
                        }
                        ProgressView(value: post.upvote_ratio).tint(.green)
                    }.fixedSize()
                    Spacer()
                    Text(""+post.num_comments.formatted(.number))
                    Image(systemName: "message.fill")
                }.font(.callout).fontWeight(.bold).padding(.bottom, 8)
            }.padding(.horizontal, 16)
        }
    }
}
