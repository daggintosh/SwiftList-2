//
//  MediaMetadataSifter.swift
//  swiftlist2
//
//  Created by Dagg on 6/14/23.
//

import SwiftUI

struct SiftMediaMetadata: View {
    let media_metadata: [String: MediaMetadata]

    var body: some View {
        ForEach(Array(media_metadata.values), id: \.p?.first?.u) { value in
            let possibleX = value.p?.last?.x ?? value.s?.x ?? 1
            let possibleY = value.p?.last?.y ?? value.s?.y ?? 1
            let possibleU = value.p?.last?.u ?? value.s?.u ?? ""
            let possibleGif = value.s?.gif
            ASIPlaceholder(width: possibleX, height: possibleY, url: possibleGif ?? URL(string: possibleU), gif: possibleGif != nil ? true : false).padding(.horizontal, 16)
        }
    }
}
