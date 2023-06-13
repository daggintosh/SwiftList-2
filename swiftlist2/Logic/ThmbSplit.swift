//
//  ThmbSplit.swift
//  swiftlist2
//
//  Created by Dagg on 6/12/23.
//

import Foundation

func split(post: ListingChildData, thumbnail: String) -> String {
    let media_metadata = post.media_metadata?.first?.value.p
    if let media_metadata = media_metadata {
        if (media_metadata.endIndex < 4) {
            return media_metadata.last?.u ?? ""
        }
        else {
            return media_metadata[3].u ?? ""
        }
    }
    
    let post_resolutions = post.preview?.images?.first?.resolutions
    if let post_resolutions = post_resolutions {
        if (post_resolutions.endIndex < 4) {
            return post_resolutions.last?.url ?? ""
        } else {
            return post_resolutions[3].url
        }
    }
    return thumbnail
}
