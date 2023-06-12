//
//  Network.swift
//  swiftlist2
//
//  Created by Dagg on 6/11/23.
//

import Foundation

var apiBaseURLNoAuth = URL(string: "https://reddit.com/")! // Switch to oauth when ready

func BaseAPI() -> URL {
    var basePath = apiBaseURLNoAuth
    basePath = basePath.appending(path: ".json")
    basePath = basePath.appending(queryItems: [URLQueryItem(name: "raw_json", value: "1")])
    return basePath
}

func GetFeed() -> [ListingChild] {
    var base = BaseAPI()
    
    var home: [ListingChild] = []
    let semaphore = DispatchSemaphore(value: 0)
    URLSession.shared.dataTask(with: base) { (data, response, error) in
        if error != nil {return}
        print((response as? HTTPURLResponse)?.statusCode)
        guard let data = data else {return}
        
        do {
            let decoded = try! JSONDecoder().decode(Listing.self, from: data)
            let decodedChildren = decoded.data.children
            home = decodedChildren
            semaphore.signal()
        }
    }.resume()
    semaphore.wait()
    return home
}
