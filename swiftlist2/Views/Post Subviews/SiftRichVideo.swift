//
//  SiftRichVideo.swift
//  swiftlist2
//
//  Created by Dagg on 6/14/23.
//

import Foundation

func extractYTVideoID(thumbnail_url: String) -> URL? {
    let match = thumbnail_url.firstMatch(of: /vi.*(?=\/)/) as Regex.Match?
    var urlString: String?
    if let match {
        let videoID = String(match.output).replacingOccurrences(of: "vi/", with: "")
        urlString = "https://www.youtube.com/embed/\(videoID)?modestbranding=1&playsinline=1"
    }
    return URL(string: urlString ?? "")
}
