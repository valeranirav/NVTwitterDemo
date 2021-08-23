//
//  NVTweetParseHelperTests.swift
//  NVTwitterDemoTests
//

import XCTest
@testable import NVTwitterDemo

class NVTweetParseHelperTests: XCTestCase {
    var correctTweetResponseData: Data?
    var incorrectTweetResponseData: Data?
    override func setUpWithError() throws {
        correctTweetResponseData = MockHelper.fetchCorrectTweetMockData()
        incorrectTweetResponseData = MockHelper.fetchIncorrectTweetMockData()
    }

    override func tearDownWithError() throws {
        correctTweetResponseData = nil
        incorrectTweetResponseData = nil
    }

    func testTweetObjectIsNotNilWhenResponseIsInCorrectFormat() {
        let tweetObject = NVTweetParseHelper.processTweet(with: correctTweetResponseData)
        XCTAssertNotNil(tweetObject)
    }

    func testTweetObjectHasDataWhenResponseIsInCorrectFormat() {
        let tweetObject = NVTweetParseHelper.processTweet(with: correctTweetResponseData)
        XCTAssertEqual(tweetObject?.count, 7)
    }

    func testTweetObjectIsNilWhenResponseIsInIncorrectFormat() {
        let tweetObject = NVTweetParseHelper.processTweet(with: incorrectTweetResponseData)
        XCTAssertNil(tweetObject)
    }
}
