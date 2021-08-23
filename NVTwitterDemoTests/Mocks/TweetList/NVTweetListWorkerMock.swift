//
//  NVTweetListWorkerMock.swift
//  NVTwitterDemoTests
//

import Foundation
@testable import NVTwitterDemo

class NVTweetListWorkerMock: NVTweetListWorkerInput {
    var getRulesCalled = 0
    var deleteRulesCalled = 0
    var addRulesCalled = 0
    var fetchFeedsCalled = 0
    var sendSuccesReeponseInGetRules = false
    var sendSuccesReeponseInDeleteRules = false
    var sendSuccesReeponseInAddRules = false
    var sendSuccesReeponseInFetchFeeds = false
    var sendRuleObject = false

    func getRules(_ completion: @escaping (Result<NVTweetRuleResponseModel, NVError>) -> Void) {
        getRulesCalled += 1
        if sendSuccesReeponseInGetRules {
            if sendRuleObject {
                let tweetRuleObject = NVTweetRuleModel(id: "1242354623", value: "I smaple:1", tag: "search for I")
                let tweetResponseObject = NVTweetRuleResponseModel(rules: [tweetRuleObject])
                completion(.success(tweetResponseObject))
            } else {
                completion(.success(NVTweetRuleResponseModel(rules: [NVTweetRuleModel]())))
            }

            return
        }
        completion(.failure(.network(string: "Error in get rules")))
    }

    func deleteRules(with ruleIdList: [String], completion: @escaping (Result<NVTweetDeleteRuleResponseModel, NVError>) -> Void) {
        deleteRulesCalled += 1
        if sendSuccesReeponseInDeleteRules {
            let tweetDeleteRuleObject = NVTweetDeleteRuleModel(deleted: 1)
            let deleteRuleSummaryObject = NVTweetDeleteRuleSummaryModel(summary: tweetDeleteRuleObject)
            let tweetDeleteRuleResponseObject = NVTweetDeleteRuleResponseModel(meta: deleteRuleSummaryObject)
            completion(.success(tweetDeleteRuleResponseObject))
            return
        }
        completion(.failure(.network(string: "Error in delete rules")))
    }

    func addRule(with keyword: String, completion: @escaping (Result<NVTweetRuleResponseModel, NVError>) -> Void) {
        addRulesCalled += 1
        if sendSuccesReeponseInAddRules {
            let tweetRuleObject = NVTweetRuleModel(id: "1242354623", value: "I smaple:1", tag: "search for I")
            let tweetResponseObject = NVTweetRuleResponseModel(rules: [tweetRuleObject])
            completion(.success(tweetResponseObject))
            return
        }
        completion(.failure(.network(string: "Error in get rules")))
    }

    func fetchFeeds(_ completion: @escaping NVFetchFeedsCompletionClosure) {
        fetchFeedsCalled += 1
        if sendSuccesReeponseInFetchFeeds {
            let geoObject = NVFeedGeoModel(type: "coordinate", coordinates: [40.74118764, -73.9998279])
            let feedObject = NVFeedModel(feedId: "3463574574", text: "Hello tweet", geo: geoObject)
            let feedResponseObject = NVFeedResponseModel(feed: feedObject)
            completion(.success([feedResponseObject]))
            return
        }
        completion(.failure(.network(string: "Error in fetch feeds")))
    }
}
