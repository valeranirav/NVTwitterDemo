//
//  NVTweetParser.swift
//  NVTwitterDemo
//
//

import Foundation

class NVTweetParseHelper {
    static func processTweet(with data: Data?) -> [NVFeedResponseModel]? {
        guard let data = data, var string = String(data: data, encoding: .utf8) else {
            return nil
        }

        let delimiter = "\r\n"
        string = string.replacingOccurrences(of: "\\r\\n", with: delimiter)
        let chunks = string.components(separatedBy: delimiter)
        let decoder = JSONDecoder()
        var feedresponseList = [NVFeedResponseModel]()
        chunks.forEach { chunk in
            do {
                guard !chunk.isEmpty, let data = chunk.data(using: .utf8) else {
                    return
                }

                let feedResponse = try decoder.decode(NVFeedResponseModel.self, from: data)
                feedresponseList.append(feedResponse)
            } catch {
                print("Parsing the data error: " + error.localizedDescription)
            }
        }
        return feedresponseList
    }
}
