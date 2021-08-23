//
//  NVTweetListPresenter.swift
//  NVTwitterDemo
//

import Foundation

protocol NVTweetListPresenterInput: AnyObject {
    func didRetrieveFeeds(_ searchedFeeds: [NVFeedResponseModel])
    func didRetriveFeedsFailed(with error: NVError)
    func didSetRuleFailed(with error: NVError)
}

final class NVTweetListPresenter {
    weak var viewController: NVTweetListViewControllerProtocol?

    init(viewController: NVTweetListViewControllerProtocol) {
        self.viewController = viewController
    }

    private func setupTweets(_ searchedFeeds: [NVFeedResponseModel]) {
        let tweets = searchedFeeds.compactMap {$0.feed.text }.compactMap { NVTweetModel(text: $0) }

        if let existingFeeds = self.viewController?.feeds, existingFeeds.isEmpty {
            viewController?.feeds.append(contentsOf: tweets)
        } else {
            tweets.forEach { tweet in
                viewController?.feeds.insert(tweet, at: 0)
            }
        }
    }
}

extension NVTweetListPresenter: NVTweetListPresenterInput {
    func didRetrieveFeeds(_ searchedFeeds: [NVFeedResponseModel]) {
        setupTweets(searchedFeeds)
        DispatchQueue.main.async {
            self.viewController?.didRetrieveFeedsSuccessful()
        }
    }

    func didRetriveFeedsFailed(with error: NVError) {
        DispatchQueue.main.async {
            self.viewController?.didRetriveFeedsFailed(with: error.localizedDescription)
        }
    }

    func didSetRuleFailed(with error: NVError) {
        DispatchQueue.main.async {
            self.viewController?.didSetRuleFailed(with: error.localizedDescription)
        }
    }
}
