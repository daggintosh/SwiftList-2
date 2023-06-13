//
//  ColorFromHex.swift
//  swiftlist2
//
//  Created by Dagg on 6/12/23.
//

import Foundation
import SwiftUI

func hexToColor(str: String, out: inout Color) -> Color {
    if str == "" {
        out = .primary
        return .secondary
    }
    var hex = str.dropFirst()
    hex.insert(",", at: hex.index(hex.startIndex, offsetBy: 2))
    
    hex.insert(",", at: hex.index(hex.startIndex, offsetBy: 5))
    
    hex.insert(",", at: hex.index(hex.startIndex, offsetBy: 8))
    let arr = hex.split(separator: ",")
    
    var convArr: [Double] = []
    arr.forEach { num in
        if let value = UInt8(num, radix: 16) {
            convArr.append(Double(value))
        }
    }
    
    if ((((convArr[0]*299) + (convArr[1]*587) + (convArr[2]*114)) / 1000) > 155) {
        out = .black
    } else {
        out = .white
    }

    return Color(red: convArr[0]/255, green: convArr[1]/255, blue: convArr[2]/255)
}
