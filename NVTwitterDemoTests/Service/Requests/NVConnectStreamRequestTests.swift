//
//  NVConnectStreamRequestTests.swift
//  NVTwitterDemoTests
//

import XCTest
@testable import NVTwitterDemo

class NVConnectStreamRequestTests: XCTestCase {
    var subject: NVConnectStreamRequest!
    override func setUpWithError() throws {
        subject = NVConnectStreamRequest()
    }

    override func tearDownWithError() throws {
        subject = nil
    }

    func testConnectStreamRequest() {
        XCTAssertNotNil(subject)    
        XCTAssertEqual(subject.baseUrl(), NVConstants.streamAPIBaseURLString)
        XCTAssertEqual(subject.contentType(), "application/json")
        XCTAssertEqual(subject.endPoint(), NVConstants.connectStreamAPIEndPoint)
        XCTAssertEqual(subject.requestType(), .GET)
        XCTAssertEqual(subject.bearerToken(), NVConstants.bearerToken)
        XCTAssertNotNil(subject.bodyParams)
    }
}
