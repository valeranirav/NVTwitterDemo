//
//  NVTwitterServiceMock.swift
//  NVTwitterDemoTests
//
//  Created by Nirav Valera on 23/08/21.
//

import Foundation
@testable import NVTwitterDemo

class NVTwitterServiceMock: NVTwitterServiceProtocol {
var getRulesCalled = 0
    var deleteRulesCalled = 0
    var addRulesCalled = 0
    var fetchFeedsCalled = 0

    func getRules(_ completion: @escaping (Result<NVTweetRuleResponseModel, NVError>) -> Void) {
        getRulesCalled += 1
    }

    func addRule(with keyword: String, completion: @escaping (Result<NVTweetRuleResponseModel, NVError>) -> Void) {
        addRulesCalled += 1
    }

    func deleteRules(with ruleIds: [String], completion: @escaping (Result<NVTweetDeleteRuleResponseModel, NVError>) -> Void) {
        deleteRulesCalled += 1
    }

    func fetchFeeds(_ completion: @escaping NVFetchFeedsCompletionClosure) {
        fetchFeedsCalled += 1
    }

    
}
