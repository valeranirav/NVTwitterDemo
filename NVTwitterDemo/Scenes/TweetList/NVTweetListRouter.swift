//
//  NVTweetListRouter.swift
//  NVTwitterDemo
//

import Foundation
import UIKit

protocol NVTweetListRouterInput: AnyObject {
    func routeToMapView()
}

final class NVTweetListRouter {
    weak var source: UIViewController?

    init(source: UIViewController) {
        self.source = source
    }
}

extension NVTweetListRouter: NVTweetListRouterInput {
    func routeToMapView() {
        let viewController = NVMapViewController()
        NVMapConfigurator.configureModule(viewController: viewController)
        source?.navigationController?.pushViewController(viewController, animated: true)
    }
}
