//
//  NVAddRuleRequestTests.swift
//  NVTwitterDemoTests
//

import XCTest
@testable import NVTwitterDemo

class NVAddRuleRequestTests: XCTestCase {
    var subject: NVAddRuleRequest!
    override func setUpWithError() throws {
        subject = NVAddRuleRequest(with: "I")
    }

    override func tearDownWithError() throws {
        subject = nil
    }

    func testAddRuleRequest() {
        XCTAssertNotNil(subject)
        XCTAssertEqual(subject.baseUrl(), NVConstants.streamAPIBaseURLString)
        XCTAssertEqual(subject.contentType(), "application/json")
        XCTAssertEqual(subject.keyword, "I")
        XCTAssertEqual(subject.endPoint(), NVConstants.rulesAPIEndPoint)
        XCTAssertEqual(subject.requestType(), .POST)
        XCTAssertEqual(subject.bearerToken(), NVConstants.bearerToken)
        XCTAssertNotNil(subject.bodyParams)
    }

}
