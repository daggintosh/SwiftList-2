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
    
    var body: some View {
        ZStack {
            var out: Color = Color.init(uiColor: UIColor.systemBackground)
            Rectangle().overlay(hexToColor(str: backgroundColor, out: &out)).cornerRadius(10)
            Text(flairText).font(.caption).fontWeight(.semibold).foregroundColor(out).padding(4)
        }.fixedSize()
    }
}
