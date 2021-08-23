//
//  NVMapInteractor.swift
//  NVTwitterDemo
//

import Foundation

protocol NVMapInteractorInput: AnyObject {
    func loadTweets()
}

final class NVMapInteractor {
    private let presenter: NVMapPresenterInput
    private let worker: NVMapWorkerInput

    init(presenter: NVMapPresenterInput, worker: NVMapWorkerInput) {
        self.presenter = presenter
        self.worker = worker
    }
}

extension NVMapInteractor: NVMapInteractorInput {
    func loadTweets() {
        let tweetData = worker.fetchTweetData()
        presenter.didRetrieveFeeds(tweetData)
    }
}
