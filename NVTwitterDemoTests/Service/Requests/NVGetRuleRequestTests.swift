//
//  NVGetRuleRequestTests.swift
//  NVTwitterDemoTests
//
//  Created by Nirav Valera on 23/08/21.
//

import XCTest
@testable import NVTwitterDemo

class NVGetRuleRequestTests: XCTestCase {
    var subject: NVGetRuleRequest!
    override func setUpWithError() throws {
        subject = NVGetRuleRequest()
    }

    override func tearDownWithError() throws {
        subject = nil
    }

    func testGetRuleRequest() {
        XCTAssertNotNil(subject)
        XCTAssertEqual(subject.baseUrl(), NVConstants.streamAPIBaseURLString)
        XCTAssertEqual(subject.contentType(), "application/json")
        XCTAssertEqual(subject.endPoint(), NVConstants.rulesAPIEndPoint)
        XCTAssertEqual(subject.requestType(), .GET)
        XCTAssertEqual(subject.bearerToken(), NVConstants.bearerToken)
    }
}
