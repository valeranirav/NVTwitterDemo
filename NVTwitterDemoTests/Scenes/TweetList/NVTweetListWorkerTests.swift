//
//  NVTweetListWorkerTests.swift
//  NVTwitterDemoTests
//
//  Created by Nirav Valera on 23/08/21.
//

import XCTest
@testable import NVTwitterDemo

class NVTweetListWorkerTests: XCTestCase {
    var subject: NVTweetListWorker!
    var serviceMock: NVTwitterServiceMock!

    override func setUpWithError() throws {
        serviceMock = NVTwitterServiceMock()
        subject = NVTweetListWorker(with: serviceMock)
    }

    override func tearDownWithError() throws {
        serviceMock = nil
        subject = nil
    }

    func testGetRuleCalledOnceOnGetRule() {
        XCTAssertEqual(serviceMock.getRulesCalled, 0)
        subject.getRules { _ in

        }
        XCTAssertEqual(serviceMock.getRulesCalled, 1)
    }

    func testAddRuleCalledOnceOnAddRule() {
        XCTAssertEqual(serviceMock.addRulesCalled, 0)
        subject.addRule(with: "I") { _ in

        }
        XCTAssertEqual(serviceMock.addRulesCalled, 1)
    }

    func testDeleteRuleCalledOnceOnDeleteRule() {
        XCTAssertEqual(serviceMock.deleteRulesCalled, 0)
        subject.deleteRules(with: ["32423525"]) { _ in
            
        }
        XCTAssertEqual(serviceMock.deleteRulesCalled, 1)
    }

    func testFetchFeedsCalledOnceOnFetchFeeds() {
        XCTAssertEqual(serviceMock.fetchFeedsCalled, 0)
        subject.fetchFeeds { _ in

        }
        XCTAssertEqual(serviceMock.fetchFeedsCalled, 1)
    }
}
