//
//  NVMapWorker.swift
//  NVTwitterDemo
//

import Foundation

protocol NVMapWorkerInput: AnyObject {
    func fetchTweetData() -> [NVFeedResponseModel]
}

final class NVMapWorker: NVRequestHandler {
    func fetchMockData(from fileName: String) -> [NVFeedResponseModel] {
        guard let data = FileManager.readJson(forResource: fileName) else {
            return [NVFeedResponseModel]()
        }

        if let feedResponseList = NVTweetParseHelper.processTweet(with: data) {
            return feedResponseList
        }

        return [NVFeedResponseModel]()
    }
}

extension NVMapWorker: NVMapWorkerInput {
    func fetchTweetData() -> [NVFeedResponseModel] {
        return fetchMockData(from: "MockTweets")
    }
}
