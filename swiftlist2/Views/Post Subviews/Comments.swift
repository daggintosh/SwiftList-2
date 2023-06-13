//
//  Comments.swift
//  swiftlist2
//
//  Created by Dagg on 6/13/23.
//

import SwiftUI

struct Comment: View {
    let comment: ListingChild
    
    var body: some View {
        VStack(alignment: .leading) {
            let data = comment.data
            HStack {
                Text("u/" + (data.author ?? "[deleted]")).font(.footnote).fontWeight(.bold)
                Spacer()
                
            }
            Text(.init(stringLiteral: data.body ?? "[deleted]"))
        }
    }
}
