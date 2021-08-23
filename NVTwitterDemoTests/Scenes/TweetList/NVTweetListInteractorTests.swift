//
//  NVTweetListInteractorTests.swift
//  NVTwitterDemoTests
//
//  Created by Nirav Valera on 23/08/21.
//

import XCTest
@testable import NVTwitterDemo

class NVTweetListInteractorTests: XCTestCase {
    var subject: NVTweetListInteractor!
    var presenterMock: NVTweetListPresenterMock!
    var workerMock: NVTweetListWorkerMock!

    override func setUpWithError() throws {
        presenterMock = NVTweetListPresenterMock()
        workerMock = NVTweetListWorkerMock()

        subject = NVTweetListInteractor(presenter: presenterMock, worker: workerMock)

    }

    override func tearDownWithError() throws {
        presenterMock = nil
        workerMock = nil
        subject = nil
    }

    func testGetRuleCalledOnceOnSearchTweet(){
        XCTAssertEqual(workerMock.getRulesCalled, 0)
        subject.searchTweet(with: "me")
        XCTAssertEqual(workerMock.getRulesCalled, 1)
    }

    func testDidSetRuleFailedCalledOnceWhenGetRuleFailed() {
        XCTAssertEqual(presenterMock.didSetRuleFailedCalled, 0)
        subject.searchTweet(with: "me")
        XCTAssertEqual(presenterMock.didSetRuleFailedCalled, 1)
        XCTAssertEqual(workerMock.deleteRulesCalled, 0)
        XCTAssertEqual(workerMock.addRulesCalled, 0)
    }

    func testDeleteRuleCalledOnceWhenGetRuleSucceededAndRuleExists() {
        XCTAssertEqual(workerMock.deleteRulesCalled, 0)

        workerMock.sendSuccesReeponseInGetRules = true
        workerMock.sendRuleObject = true
        subject.searchTweet(with: "me")
        XCTAssertEqual(workerMock.deleteRulesCalled, 1)        
    }

    func testAddRuleCalledOnceWhenGetRuleSucceededAndRuleDoesNotExists() {
        XCTAssertEqual(workerMock.addRulesCalled, 0)

        workerMock.sendSuccesReeponseInGetRules = true
        subject.searchTweet(with: "me")
        XCTAssertEqual(workerMock.addRulesCalled, 1)
        XCTAssertEqual(workerMock.deleteRulesCalled, 0)
    }

    func testAddRuleCalledOnceWhenGetRuleSucceededAndExistingRuleDeletedSuccessfully() {
        XCTAssertEqual(workerMock.addRulesCalled, 0)

        workerMock.sendSuccesReeponseInGetRules = true
        workerMock.sendRuleObject = true
        workerMock.sendSuccesReeponseInDeleteRules = true

        subject.searchTweet(with: "me")
        XCTAssertEqual(workerMock.addRulesCalled, 1)
    }

    func testDidSetRuleFailedCalledOnceWhenGetRuleSucceededRuleExistButDeleteRuleFailed() {
        XCTAssertEqual(workerMock.deleteRulesCalled, 0)
        XCTAssertEqual(presenterMock.didSetRuleFailedCalled, 0)

        workerMock.sendSuccesReeponseInGetRules = true
        workerMock.sendRuleObject = true
        subject.searchTweet(with: "me")
        XCTAssertEqual(workerMock.deleteRulesCalled, 1)
        XCTAssertEqual(presenterMock.didSetRuleFailedCalled, 1)
    }

    func testDidSetRuleFailedCalledOnceWhenGetRuleSucceededAndExistingRuleDeletedSuccessfullyButAddRuleFailed() {
        XCTAssertEqual(workerMock.addRulesCalled, 0)
        XCTAssertEqual(presenterMock.didSetRuleFailedCalled, 0)

        workerMock.sendSuccesReeponseInGetRules = true
        workerMock.sendRuleObject = true
        workerMock.sendSuccesReeponseInDeleteRules = true
        workerMock.sendSuccesReeponseInAddRules = false

        subject.searchTweet(with: "me")
        XCTAssertEqual(workerMock.addRulesCalled, 1)
        XCTAssertEqual(presenterMock.didSetRuleFailedCalled, 1)
    }

    func testDidSetRuleFailedCalledOnceWhenGetRuleSucceededAndNoRuleExistsButAddRuleFailed() {
        XCTAssertEqual(workerMock.addRulesCalled, 0)
        XCTAssertEqual(presenterMock.didSetRuleFailedCalled, 0)

        workerMock.sendSuccesReeponseInGetRules = true
        workerMock.sendSuccesReeponseInAddRules = false

        subject.searchTweet(with: "me")
        XCTAssertEqual(workerMock.addRulesCalled, 1)
        XCTAssertEqual(presenterMock.didSetRuleFailedCalled, 1)
    }

    func testAddRuleCalledOnceWhenGetRuleSucceededAndNoRuleExists() {
        XCTAssertEqual(workerMock.addRulesCalled, 0)

        workerMock.sendSuccesReeponseInGetRules = true
        subject.searchTweet(with: "me")
        XCTAssertEqual(workerMock.addRulesCalled, 1)
    }

    func testDeleteRuleDoesNotCalledWhenGetRuleSucceededAndNoRuleExists() {
        XCTAssertEqual(workerMock.deleteRulesCalled, 0)

        workerMock.sendSuccesReeponseInGetRules = true
        subject.searchTweet(with: "me")
        XCTAssertEqual(workerMock.deleteRulesCalled, 0)
    }

    func testFetchFeedsCalledOnceWhenGetRuleSucceededAndNoRuleExistsButAddRuleSucceeded() {
        XCTAssertEqual(workerMock.fetchFeedsCalled, 0)

        workerMock.sendSuccesReeponseInGetRules = true
        workerMock.sendSuccesReeponseInAddRules = true

        subject.searchTweet(with: "me")
        XCTAssertEqual(workerMock.fetchFeedsCalled, 1)
    }

    func testFetchFeedsCalledOnceWhenGetRuleSucceededAndExistingRuleDeletedSuccessfullyAndAddRuleSucceeded() {
        XCTAssertEqual(workerMock.fetchFeedsCalled, 0)

        workerMock.sendSuccesReeponseInGetRules = true
        workerMock.sendRuleObject = true
        workerMock.sendSuccesReeponseInDeleteRules = true
        workerMock.sendSuccesReeponseInAddRules = true

        subject.searchTweet(with: "me")
        XCTAssertEqual(workerMock.fetchFeedsCalled, 1)
    }

    func testDidRetrieveFeedsCalledOnceWhenFetchFeedsSucceeded() {
        XCTAssertEqual(presenterMock.didRetrieveFeedsCalled, 0)

        workerMock.sendSuccesReeponseInGetRules = true
        workerMock.sendRuleObject = true
        workerMock.sendSuccesReeponseInDeleteRules = true
        workerMock.sendSuccesReeponseInAddRules = true
        workerMock.sendSuccesReeponseInFetchFeeds = true

        subject.searchTweet(with: "me")
        XCTAssertEqual(presenterMock.didRetrieveFeedsCalled, 1)
    }

    func testDidRetriveFeedsFailedCalledOnceWhenFetchFeedsSucceeded() {
        XCTAssertEqual(presenterMock.didRetriveFeedsFailedCalled, 0)

        workerMock.sendSuccesReeponseInGetRules = true
        workerMock.sendRuleObject = true
        workerMock.sendSuccesReeponseInDeleteRules = true
        workerMock.sendSuccesReeponseInAddRules = true        

        subject.searchTweet(with: "me")
        XCTAssertEqual(presenterMock.didRetriveFeedsFailedCalled, 1)
    }
}

