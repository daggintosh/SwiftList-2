//
//  Search.swift
//  swiftlist2
//
//  Created by Dagg on 6/13/23.
//

import SwiftUI

struct Search: View {
    @State var searchText: String
    
    var body: some View {
        TextField(text: $searchText) {
            Text("Test")
        }
    }
}
