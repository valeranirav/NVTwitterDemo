//
//  NVTweetListPresenterMock.swift
//  NVTwitterDemoTests
//

import Foundation
@testable import NVTwitterDemo

class NVTweetListPresenterMock: NVTweetListPresenterInput {
    var didRetrieveFeedsCalled = 0
    var didRetriveFeedsFailedCalled = 0
    var didSetRuleFailedCalled = 0
    
    func didRetrieveFeeds(_ searchedFeeds: [NVFeedResponseModel]) {
        didRetrieveFeedsCalled += 1
    }

    func didRetriveFeedsFailed(with error: NVError) {
        didRetriveFeedsFailedCalled += 1
    }

    func didSetRuleFailed(with error: NVError) {
        didSetRuleFailedCalled += 1
    }
}
