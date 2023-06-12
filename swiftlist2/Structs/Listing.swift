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
    let num_comments: Int64
    let subreddit_subscribers: Int64
}

struct Edited: Codable {
    let isEdited: Bool
    let editDate: Int64

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        do {
            let val = try container.decode(Bool.self)
            isEdited = val
            editDate = 0
        }
        catch {
            let val = try container.decode(Int64.self)
            isEdited = true
            editDate = val
            
        }
    }
}
