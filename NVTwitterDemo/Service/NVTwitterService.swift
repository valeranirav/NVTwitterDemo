//
//  NVTwitterService.swift
//  NVTwitterDemo
//

import Foundation

protocol NVTwitterServiceProtocol {
    func getRules(_ completion: @escaping (Result<NVTweetRuleResponseModel, NVError>) -> Void)
    func addRule(with keyword: String, completion: @escaping (Result<NVTweetRuleResponseModel, NVError>) -> Void)
    func deleteRules(
        with ruleIds: [String],
        completion: @escaping (Result<NVTweetDeleteRuleResponseModel, NVError>) -> Void
    )
    func fetchFeeds(_ completion: @escaping NVFetchFeedsCompletionClosure)
}

final class NVTwitterService: NVRequestHandler {
    var task: URLSessionTask?

    private func cancelTask() {
        if let task = task {
            task.cancel()
        }
        task = nil
    }
}

extension NVTwitterService: NVTwitterServiceProtocol {
    func getRules(_ completion: @escaping (Result<NVTweetRuleResponseModel, NVError>) -> Void) {
        cancelTask()

        let getRuleRequest = NVGetRuleRequest()
        guard let request = NVRequestFactory.request(for: getRuleRequest) else {
            completion(.failure(.network(string: "Invalid url")))
            return
        }

        task = NVRequestService().loadData(request: request, completion: self.networkResult(completion: completion))
    }

    func addRule(with keyword: String, completion: @escaping (Result<NVTweetRuleResponseModel, NVError>) -> Void) {
        cancelTask()

        let addRuleRequest = NVAddRuleRequest(with: keyword)
        guard let request = NVRequestFactory.request(for: addRuleRequest) else {
            completion(.failure(.network(string: "Invalid url")))
            return
        }

        task = NVRequestService().loadData(request: request, completion: self.networkResult(completion: completion))
    }

    func deleteRules(
        with ruleIds: [String],
        completion: @escaping (Result<NVTweetDeleteRuleResponseModel, NVError>) -> Void
    ) {
        cancelTask()

        let deleteRuleRequest = NVDeleteRuleRequest(with: ruleIds)
        guard let request = NVRequestFactory.request(for: deleteRuleRequest) else {
            completion(.failure(.network(string: "Invalid url")))
            return
        }

        task = NVRequestService().loadData(request: request, completion: self.networkResult(completion: completion))
    }

    func fetchFeeds(_ completion: @escaping NVFetchFeedsCompletionClosure) {
        cancelTask()

        let connectStreamRequest = NVConnectStreamRequest()
        guard let request = NVRequestFactory.request(for: connectStreamRequest) else {
            completion(.failure(.network(string: "Invalid url")))
            return
        }

        task = NVRequestService().connect(request: request) { result in
            switch result {
            case .success(let feedResponse):
                if let feedResponseList = NVTweetParseHelper.processTweet(with: feedResponse) {
                    completion(.success(feedResponseList))
                } else {
                    completion(.failure(.custom(string: "No data available")))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
