//
//  Network.swift
//  swiftlist2
//
//  Created by Dagg on 6/11/23.
//

import Foundation

var apiBaseURLNoAuth = URL(string: "https://reddit.com/")! // Switch to oauth when ready

func BaseAPI(path: String?) -> URL {
    var basePath = apiBaseURLNoAuth
    if let path = path {
        basePath = basePath.appending(path: path)
    }
    basePath = basePath.appendingPathExtension("json")
    basePath = basePath.appending(queryItems: [URLQueryItem(name: "raw_json", value: "1")])
    return basePath
}

func GetFeed(path: String?, status: inout Int) -> [ListingChild] {
    print("Fetching feed, make sure the application doesn't spam this!")
    let base = BaseAPI(path: path)

    var home: [ListingChild] = []
    let semaphore = DispatchSemaphore(value: 0)
    var statusStage: Int = 0
    URLSession.shared.dataTask(with: base) { (data, response, error) in
        if let error = error {
            print(error.localizedDescription)
            semaphore.signal()
            return
        }
        
        let responseU = response as! HTTPURLResponse
        statusStage = responseU.statusCode
        if [403, 429].contains(responseU.statusCode) {
            semaphore.signal()
            return
        }
        
        guard let data = data else {
            semaphore.signal()
            return
        }
        
        do {
            let decoded = try JSONDecoder().decode(Listing.self, from: data)
            let decodedChildren = decoded.data.children
            home = decodedChildren
            semaphore.signal()
        } catch {
            print("Error unmarshalling JSON, details: \(error.localizedDescription)")
            semaphore.signal()
            return
        }
    }.resume()
    semaphore.wait()
    status = statusStage
    return home
}
