//
//  NewsFeedInteractor.swift
//  VKNewsFeed
//
//  Created by Vadim Labun on 9/27/19.
//  Copyright (c) 2019 Vadim Labun. All rights reserved.
//

import UIKit

protocol NewsFeedBusinessLogic {
    func makeRequest(request: NewsFeed.Model.Request.RequestType)
}

class NewsFeedInteractor: NewsFeedBusinessLogic {
    
    var presenter: NewsFeedPresentationLogic?
    var service: NewsFeedService?
    private var revealedPostIds = [Int]()
    private var feedResponse: FeedResponse?
    
    private var fetcher: DataFetcher = NetworkDataFetcher(networking: NetworkService())
    
    
    func makeRequest(request: NewsFeed.Model.Request.RequestType) {
        if service == nil {
            service = NewsFeedService()
        }
        switch request {
        case .getNewsFeed:
            fetcher.getFeed { [weak self ] (feedResponse) in
                self?.feedResponse = feedResponse
                self?.presentFeed()
            }
        case .revealPostIds(let postId):
            revealedPostIds.append(postId)
            presentFeed()
        }
    }
    
    private func presentFeed() {
        guard let feedResponse = self.feedResponse else { return }
        presenter?.presentData(response: NewsFeed.Model.Response.ResponseType.presentNewsFeet(feed: feedResponse, revealedPostIds: revealedPostIds))
    }
}
