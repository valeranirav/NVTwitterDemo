//
//  MockHelper.swift
//  NVTwitterDemoTests
//
//  Created by Nirav Valera on 23/08/21.
//

import Foundation
@testable import NVTwitterDemo

class MockHelper {
    static func fetchCorrectTweetMockData() -> Data? {
        fetchTweetMockData(from: "MockTweets")
    }

    static func fetchIncorrectTweetMockData() -> Data? {
        fetchTweetMockData(from: "IncorrectMockTweets")
    }

    private static func fetchTweetMockData(from fileName: String) -> Data? {
        guard let data = FileManager.readJson(forResource: fileName) else {
            return nil
        }
        return data
    }
}
