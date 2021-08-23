//
//  NVTweetListViewControllerMock.swift
//  NVTwitterDemoTests
//

import Foundation
@testable import NVTwitterDemo

class NVTweetListViewControllerMock: NVTweetListViewControllerProtocol {
    var feeds: [NVTweetModel] = [NVTweetModel]()
    var didRetrieveFeedsSuccessfulCalled = 0
    var didRetriveFeedsFailedCalled = 0
    var didSetRuleFailedCalled = 0

    func didRetrieveFeedsSuccessful() {
        didRetrieveFeedsSuccessfulCalled += 1
    }

    func didRetriveFeedsFailed(with errorDescription: String) {
        didRetriveFeedsFailedCalled += 1
    }

    func didSetRuleFailed(with errorDescription: String) {
        didSetRuleFailedCalled += 1
    }
}
