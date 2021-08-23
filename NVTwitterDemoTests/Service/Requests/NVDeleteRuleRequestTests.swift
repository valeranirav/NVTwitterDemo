//
//  NVDeleteRuleRequestTests.swift
//  NVTwitterDemoTests
//

import XCTest
@testable import NVTwitterDemo

class NVDeleteRuleRequestTests: XCTestCase {
    var subject: NVDeleteRuleRequest!
    override func setUpWithError() throws {
        subject = NVDeleteRuleRequest(with: ["2352324562346", "34636457456746"])
    }

    override func tearDownWithError() throws {
        subject = nil
    }

    func testDeleteRuleRequest() {
        XCTAssertNotNil(subject)
        XCTAssertEqual(subject.ruleIds.count, 2)
        XCTAssertEqual(subject.baseUrl(), NVConstants.streamAPIBaseURLString)
        XCTAssertEqual(subject.contentType(), "application/json")
        XCTAssertEqual(subject.endPoint(), NVConstants.rulesAPIEndPoint)
        XCTAssertEqual(subject.requestType(), .POST)
        XCTAssertEqual(subject.bearerToken(), NVConstants.bearerToken)
        XCTAssertNotNil(subject.bodyParams)
    }
}
