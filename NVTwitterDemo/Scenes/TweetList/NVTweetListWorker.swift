//
//  NVTweetListWorker.swift
//  NVTwitterDemo
//

import Foundation

typealias NVFetchFeedsCompletionClosure = (Result<[NVFeedResponseModel], NVError>) -> Void

protocol NVTweetListWorkerInput: AnyObject {
    func getRules(_ completion: @escaping (Result<NVTweetRuleResponseModel, NVError>) -> Void)
    func deleteRules(
        with ruleIdList: [String],
        completion: @escaping (Result<NVTweetDeleteRuleResponseModel, NVError>) -> Void
    )
    func addRule(with keyword: String, completion: @escaping (Result<NVTweetRuleResponseModel, NVError>) -> Void)
    func fetchFeeds(_ completion: @escaping NVFetchFeedsCompletionClosure)
}

final class NVTweetListWorker: NVRequestHandler {
    let service: NVTwitterServiceProtocol

    init(with service: NVTwitterServiceProtocol) {
        self.service = service
    }
}

extension NVTweetListWorker: NVTweetListWorkerInput {
    func getRules(_ completion: @escaping ((Result<NVTweetRuleResponseModel, NVError>) -> Void)) {
        service.getRules(completion)
    }

    func deleteRules(
        with ruleIdList: [String],
        completion: @escaping (Result<NVTweetDeleteRuleResponseModel, NVError>) -> Void
    ) {
        service.deleteRules(with: ruleIdList, completion: completion)
    }

    func addRule(with keyword: String, completion: @escaping (Result<NVTweetRuleResponseModel, NVError>) -> Void) {
        service.addRule(with: keyword, completion: completion)
    }

    func fetchFeeds(_ completion: @escaping NVFetchFeedsCompletionClosure) {
        service.fetchFeeds(completion)
    }
}
