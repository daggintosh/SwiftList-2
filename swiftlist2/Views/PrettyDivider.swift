//
//  Pretty Divider.swift
//  swiftlist2
//
//  Created by Dagg on 6/13/23.
//

import SwiftUI

struct PrettyDivider: View {
    var body: some View {
        Divider().frame(height: 2).overlay(.secondary).padding(.horizontal, -16)
    }
}
