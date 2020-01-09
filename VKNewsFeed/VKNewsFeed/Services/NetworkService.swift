//
//  NetworkService.swift
//  VKNewsFeed
//
//  Created by Vadim Labun on 9/27/19.
//  Copyright © 2019 Vadim Labun. All rights reserved.
//

import Foundation

protocol Networking {
    func request(patch: String, params: [String:String], completion: @escaping (Data?, Error?) -> Void)
}

final class NetworkService: Networking {
    
    private let authService: AuthService
    init(authService: AuthService = AppDelegate.shared().authService) {
        self.authService = authService
    }
    
    func request(patch: String, params: [String : String], completion: @escaping (Data?, Error?) -> Void) {
        guard let token = authService.token else {return}
        var allParams = params
        allParams["access_token"] = token
        allParams["v"] = API.version
        let url = self.url(from: API.newsFeed, params: allParams)
        let request = URLRequest(url: url)
        let task = createDataTask(request: request, completion: completion)
        task.resume()
        print(task)
    }
    
    private func createDataTask(request: URLRequest, completion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request) { (data, response, error) in
             DispatchQueue.main.async {
                completion(data, error)
            }
        }
    }
    
    private func url(from patch: String, params: [String:String]) -> URL {
        var components = URLComponents()
        
        components.scheme = API.scheme
        components.host = API.host
        components.path = API.newsFeed
        components.queryItems = params.map{ URLQueryItem(name: $0, value: $1)}
        return components.url!
    }
}
