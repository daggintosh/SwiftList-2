//
//  ASIPlaceholder.swift
//  swiftlist2
//
//  Created by Dagg on 6/13/23.
//

import SwiftUI

struct ASIPlaceholder: View {
    let width: Float?
    let height: Float?
    let url: URL?
    var gif: Bool = false
    
    var body: some View {
        if !gif {
            AsyncImage(url: url) { Image in
                Image.resizable().aspectRatio(contentMode: .fit).padding(.horizontal, -16)
            } placeholder: {
                ZStack {
                    Rectangle().fill(.black).aspectRatio(Double((width ?? 1)/(height ?? 1)), contentMode: .fit).padding(.horizontal, -16)
                    ProgressView().tint(.white)
                }
            }
        } else {
            WebView(url: url).aspectRatio(Double((width ?? 1)/(height ?? 1)), contentMode: .fit).padding(.horizontal, -16)
        }
    }
}
