//
//  Network.swift
//  swiftlist2
//
//  Created by Dagg on 6/11/23.
//

import Foundation

func BaseAPI(path: String?, authenticated: Bool = false) -> URL {
    var basePath = URL(string: "https://reddit.com/")!
    
    if authenticated {
        basePath = URL(string: "https://oauth.reddit.com/")!
    }

    if let path = path {
        basePath = basePath.appending(path: path)
    }
    basePath = basePath.appendingPathExtension("json")
    basePath = basePath.appending(queryItems: [URLQueryItem(name: "raw_json", value: "1")])
    return basePath
}

func SendRequest(path: String, desiredType: Decodable.Type, status: inout Int, postRequest: Bool = false) -> Decodable? {
    print("Fetching, make sure the application doesn't spam this!")
    let base = BaseAPI(path: path)
    
    var desiredArray: Decodable?
    let semaphore = DispatchSemaphore(value: 0)
    var statusStage: Int = 0
    URLSession.shared.dataTask(with: base) {(data, response, error) in
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
            desiredArray = try! JSONDecoder().decode(desiredType.self, from: data)
            semaphore.signal()
        } catch {
            print("Error unmarshalling JSON, details: \(error.localizedDescription)")
            semaphore.signal()
            return
        }
    }.resume()
    semaphore.wait()
    status = statusStage

    return desiredArray
}

func GetAPI(path: String, status: inout Int) -> [ListingChild] {
    var home: [ListingChild] = []
//    let semaphore = DispatchSemaphore(value: 0)
    do {
        if let request = SendRequest(path: path, desiredType: Listing.self, status: &status) as? Listing {
            home = request.data.children
        }
    }
    return home
//
//    var statusStage: Int = 0
//    URLSession.shared.dataTask(with: base) { (data, response, error) in
//        if let error = error {
//            print(error.localizedDescription)
//            semaphore.signal()
//            return
//        }
//        
//        let responseU = response as! HTTPURLResponse
//        statusStage = responseU.statusCode
//        if [403, 429].contains(responseU.statusCode) {
//            semaphore.signal()
//            return
//        }
//        
//        guard let data = data else {
//            semaphore.signal()
//            return
//        }
//        
//        do {
//            let decoded = try JSONDecoder().decode(Listing.self, from: data)
//            let decodedChildren = decoded.data.children
//            home = decodedChildren
//            semaphore.signal()
//        } catch {
//            print("Error unmarshalling JSON, details: \(error.localizedDescription)")
//            semaphore.signal()
//            return
//        }
//    }.resume()
//    semaphore.wait()
//    status = statusStage
//    return home
}

func GetAPI(id: String, status: inout Int) -> [Listing] {
    var post: [Listing] = []
    do {
        if let request = SendRequest(path: id, desiredType: [Listing].self, status: &status) as? [Listing] {
            post = request
        }
    }
    return post
}
