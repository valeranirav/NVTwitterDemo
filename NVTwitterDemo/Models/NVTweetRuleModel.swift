//
//  NVTweetRule.swift
//  NVTwitterDemo
//
//

import Foundation

struct NVTweetRuleResponseModel: Decodable {
    let rules: [NVTweetRuleModel]

    enum CodingKeys: String, CodingKey {
        case rules = "data"
    }
}

struct NVTweetRuleModel: Decodable {
    let id: String
    let value: String?
    let tag: String?
}

struct NVTweetDeleteRuleResponseModel: Decodable {
    let meta: NVTweetDeleteRuleSummaryModel
}

struct NVTweetDeleteRuleSummaryModel: Decodable {
    let summary: NVTweetDeleteRuleModel
}

struct NVTweetDeleteRuleModel: Decodable {
    let deleted: Int?
}
