//
//  Pretty Divider.swift
//  swiftlist2
//
//  Created by Dagg on 6/13/23.
//

import SwiftUI

struct PrettyDividerTop: View {
    var body: some View {
        Divider().frame(height: 2).overlay(.secondary).padding(.horizontal, -16).padding(.top, -8)
    }
}
struct PrettyDividerBottom: View {
    var body: some View {
        Divider().frame(height: 2).overlay(.secondary).padding(.horizontal, -16).padding(.bottom, 8)
    }
}
