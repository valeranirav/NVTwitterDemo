//
//  NVTweetListInteractorMock.swift
//  NVTwitterDemoTests
//

import Foundation
@testable import NVTwitterDemo

class NVTweetListInteractorMock: NVTweetListInteractorInput {
    var searchTweetCalled = 0
    
    func searchTweet(with keyword: String) {
        searchTweetCalled += 1
    }
}
