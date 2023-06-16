//
//  NiceFlair.swift
//  swiftlist2
//
//  Created by Dagg on 6/13/23.
//

import SwiftUI

struct NiceFlair: View {
    let flairText: String
    let backgroundColor: String
    var flairTextColor: String = "light"
    
    var body: some View {
        ZStack {
            Rectangle().overlay(hexToColor(str: backgroundColor)).cornerRadius(10)
            let flairTextColorConv: Color = flairTextColor == "dark" ? .black : .white
            if backgroundColor == "" {
                Text(flairText).font(.caption).fontWeight(.semibold).foregroundColor(Color.init(uiColor: .systemBackground)).padding(4)
            } else {
                Text(flairText).font(.caption).fontWeight(.semibold).foregroundColor(flairTextColorConv).padding(4)
            }
        }.fixedSize()
    }
}
