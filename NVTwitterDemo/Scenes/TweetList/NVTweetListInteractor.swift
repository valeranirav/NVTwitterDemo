//
//  NVTweetListInteractor.swift
//  NVTwitterDemo
//

import Foundation

protocol NVTweetListInteractorInput: AnyObject {
    func searchTweet(with keyword: String)
}

final class NVTweetListInteractor {
    private let presenter: NVTweetListPresenterInput
    private let worker: NVTweetListWorkerInput

    private var searchKeyword = ""

    init(presenter: NVTweetListPresenterInput, worker: NVTweetListWorkerInput) {
        self.presenter = presenter
        self.worker = worker
    }

    private func fetchFeeds() {
        worker.fetchFeeds({ [weak self] result in
            guard let strongSelf = self else {
                return
            }

            switch result {
            case .success(let feedResponse):
                strongSelf.presenter.didRetrieveFeeds(feedResponse)

            case .failure(let error):
                strongSelf.presenter.didRetriveFeedsFailed(with: error)
            }
        })
    }

    private func handleGetRulesResponse(_ result: Result<NVTweetRuleResponseModel, NVError>) {
        switch result {
        case .success(let ruleResponse):
            let rules = ruleResponse.rules
            if !rules.isEmpty {
                let rulesIds = rules.compactMap { $0.id }
                worker.deleteRules(with: rulesIds) { [weak self] result in
                    guard let strongSelf = self else {
                        return
                    }
                    strongSelf.handleDeleteRulesResponse(result)
                }
            } else {
                worker.addRule(with: searchKeyword) { [weak self] result in
                    guard let strongSelf = self else {
                        return
                    }
                    strongSelf.handleAddRulesResponse(result)
                }
            }
        case .failure(let error):
            presenter.didSetRuleFailed(with: .custom(string: "Error in get rule: \(error.localizedDescription)"))
        }
    }

    private func handleDeleteRulesResponse(_ result: Result<NVTweetDeleteRuleResponseModel, NVError>) {
        switch result {
        case .success(_):
            worker.addRule(with: searchKeyword) { [weak self] result in
                guard let strongSelf = self else {
                    return
                }
                strongSelf.handleAddRulesResponse(result)
            }

        case .failure(let error):
            presenter.didSetRuleFailed(with: error)
        }
    }

    private func handleAddRulesResponse(_ result: (Result<NVTweetRuleResponseModel, NVError>)) {
        switch result {
        case .success(_):
            fetchFeeds()

        case .failure(let error):
            presenter.didSetRuleFailed(with: error)
        }
    }
}

extension NVTweetListInteractor: NVTweetListInteractorInput {
    func searchTweet(with keyword: String) {
        searchKeyword = keyword
        worker.getRules { [weak self] result in
            guard let strongSelf = self else {
                return
            }
            strongSelf.handleGetRulesResponse(result)
        }
    }
}
