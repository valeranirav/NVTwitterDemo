//
//  NVMapConfigurator.swift
//  NVTwitterDemo
//

import Foundation

final class NVMapConfigurator {
    static func configureModule(viewController: NVMapViewController) {
        let view = NVMapView()
        let worker = NVMapWorker()
        let router = NVMapRouter(source: viewController)
        let presenter = NVMapPresenter(viewController: viewController)
        let interactor = NVMapInteractor(presenter: presenter, worker: worker)

        viewController.mapView = view
        viewController.router = router
        viewController.interactor = interactor
    }
}
