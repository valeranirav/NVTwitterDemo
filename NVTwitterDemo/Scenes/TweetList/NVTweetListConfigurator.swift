//
//  NVTweetListConfigurator.swift
//  NVTwitterDemo
//

import Foundation

final class NVTweetListConfigurator {
    static func configureModule(viewController: NVTweetListViewController) {
        let service = NVTwitterService()
        let view = NVTweetListView()
        let worker = NVTweetListWorker(with: service)
        let router = NVTweetListRouter(source: viewController)
        let presenter = NVTweetListPresenter(viewController: viewController)
        let interactor = NVTweetListInteractor(presenter: presenter, worker: worker)

        viewController.tweetListView = view
        viewController.router = router
        viewController.interactor = interactor
    }
}
