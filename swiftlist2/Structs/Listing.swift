//
//  Listing.swift
//  swiftlist2
//
//  Created by Dagg on 6/11/23.
//

import Foundation

struct Listing: Decodable {
    let data: ListingData
}

struct ListingData: Decodable {
    let dist: Int
    let children: [ListingChild]
}

struct ListingChild: Decodable {
    let data: ListingChildData
}

struct ListingChildData: Decodable, Identifiable {
    let id: String
    let selftext: String?
    let author: String
    let title: String
    let subreddit_name_prefixed: String
    let upvote_ratio: Float
    let ups: Int64
    let edited: Edited
    let created_utc: Float64
    let over_18: Bool
    let spoiler: Bool
    let author_flair_text: String?
    let link_flair_text: String?
    let link_flair_background_color: String?
    let num_comments: Int64
    let subreddit_subscribers: Int64
    let post_hint: String?
    let thumbnail: String?
    let thumbnail_height: Float?
    let thumbnail_width: Float?
    let url: String?
    let secure_media: SecureMedia?
    let media_metadata: Dictionary<String, MediaMetadata>?
    let preview: Preview?
}

struct MediaMetadata: Decodable {
    let p: [MMURL]?
    let s: MMURL?
}
struct MMURL: Decodable {
    let y: Float?
    let x: Float?
    let u: String?
}

struct Preview: Decodable {
    let images: [PreviewImages]?
}

struct PreviewImages: Decodable {
    let source: IMGURL?
    let resolutions: [IMGURL]?
}

struct IMGURL: Decodable {
    let width: Float?
    let height: Float?
    let url: String
}

struct SecureMedia: Decodable {
    let oembed: Oembed?
    let reddit_video: RedditVideo?
}
struct Oembed: Decodable {
    let provider_name: String
    let thumbnail_url: String?
    let html: String
}
struct RedditVideo: Decodable {
    let hls_url: String
    let is_gif: Bool
}

struct Edited: Decodable {
    let isEdited: Bool
    let editDate: Int64

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        do {
            let val = try container.decode(Bool.self)
            isEdited = val
            editDate = 0
        } catch {
            let val = try container.decode(Int64.self)
            isEdited = true
            editDate = val
        }
    }
}
