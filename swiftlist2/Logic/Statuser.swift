//
//  Statuser.swift
//  swiftlist2
//
//  Created by Dagg on 6/14/23.
//

import Foundation

func Statuser(status: Int) -> String? {
    switch status {
    case 403:
        return "Forbidden.\nTry again another day."
    case 429:
        return "Rate limited.\nWait a minute and try again."
    default:
        return nil
    }
}
