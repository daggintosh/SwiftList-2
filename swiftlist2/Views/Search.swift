//
//  Search.swift
//  swiftlist2
//
//  Created by Dagg on 6/13/23.
//

import SwiftUI

struct Search: View {
    @State var searchText: String = ""
    
    var body: some View {
        VStack {
            HStack {
                ZStack {
                    Rectangle().cornerRadius(10).foregroundColor(.init(uiColor: UIColor.darkGray)).layoutPriority(-1)
                    HStack {
                        Image(systemName: "magnifyingglass")
                        TextField("Search", text: $searchText)
                    }.padding(4)
                }
                Button {
                    
                } label: {
                    Text("Go")
                }

            }.padding()
            Spacer()
        }.navigationTitle("Search")
    }
}
