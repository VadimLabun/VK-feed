//
//  NetworkDataFetcher.swift
//  VKNewsFeed
//
//  Created by Vadim Labun on 9/27/19.
//  Copyright © 2019 Vadim Labun. All rights reserved.
//

import Foundation

protocol DataFetcher {
    func getFeed(response: @escaping (FeedResponse?) -> Void)
}
struct NetworkDataFetcher: DataFetcher {
    
    let networking: Networking
    init(networking: Networking) {
        self.networking = networking
    }
    
    func getFeed(response: @escaping (FeedResponse?) -> Void) {
        let params = ["filters":"post, photo"]
        networking.request(patch: API.newsFeed, params: params) { (data, error) in
            if let error = error {
                print(error.localizedDescription)
                response(nil)
            }
            let decoded = self.decodeJson(type: FeedResponseWrapped.self, from: data)
            response(decoded?.response)
        }
    }
    private func decodeJson<T: Decodable>(type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let data = from, let response = try? decoder.decode(type, from: data) else {return nil}
        return response
    }
    
}
