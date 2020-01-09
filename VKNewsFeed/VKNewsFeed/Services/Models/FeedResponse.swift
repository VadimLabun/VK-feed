//
//  FeedResponse.swift
//  VKNewsFeed
//
//  Created by Vadim Labun on 9/27/19.
//  Copyright © 2019 Vadim Labun. All rights reserved.
//

import Foundation

struct FeedResponseWrapped: Decodable {
    let response: FeedResponse
}
struct FeedResponse: Decodable {
    var items: [FeedItem]
    var profiles: [Profile]
    var groups: [Group]
}
struct FeedItem: Decodable {
    let sourceId: Int
    let postId: Int
    let text: String?
    let date: Double
    let comments: CountableItem?
    let likes: CountableItem?
    let reposts: CountableItem?
    let views: CountableItem?
    let attachments: [Attachments]?
}
struct Attachments: Decodable {
    let photo: Photo?
}
struct Photo: Decodable {
    let sizes: [PhotoSize]
    
    var height: Int {
        return getPropperSize().height
    }
    var width: Int {
        return getPropperSize().width
    }
    var srsBig: String {
        return getPropperSize().url
    }
    
    private func getPropperSize() -> PhotoSize {
        if let sizeX = sizes.first(where: { $0.type == "x"}) {
        return sizeX
        } else if let fallBackSize = sizes.last {
            return fallBackSize
        } else {
            return PhotoSize(type: "Wrong image", url: "Wrong image", width: 0, height: 0)
        }
    }
}
struct PhotoSize: Decodable {
    let type: String
    let url: String
    let width: Int
    let height: Int
}
struct CountableItem: Decodable {
    let count: Int
}
protocol ProfileRepresentsble {
    var id: Int { get }
    var name: String { get }
    var photo: String { get }
}
struct Profile: Decodable, ProfileRepresentsble {
    let id: Int
    let firstName: String
    let lastName: String
    let photo100: String
    
    var photo: String { return photo100 }
    var name: String { return firstName + " " + lastName }
}
struct Group: Decodable, ProfileRepresentsble {
    
    let id: Int
    let name: String
    let photo100: String
    
    var photo: String { return photo100 }

}

