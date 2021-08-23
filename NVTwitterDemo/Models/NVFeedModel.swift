//
//  NVFeedModel.swift
//  NVTwitterDemo
//
//

import Foundation

struct NVFeedResponseModel: Decodable {
    let feed: NVFeedModel

    enum CodingKeys: String, CodingKey {
        case feed = "data"
    }
}

struct NVFeedModel: Decodable {
    let feedId: String
    let text: String?
    let geo: NVFeedGeoModel?

    enum CodingKeys: String, CodingKey {
        case feedId = "id"
        case text
        case geo
    }
}

struct NVFeedGeoModel: Decodable {
    let type: String?
    let coordinates: [Double]?
}

struct NVTweetModel {
    let text: String
}
