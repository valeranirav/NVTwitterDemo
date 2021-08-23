//
//  NVMapViewController.swift
//  NVTwitterDemo
//

import UIKit

protocol NVMapViewControllerProtocol: AnyObject {
    var feedLocations: [NVTweetLocation] { get set }

    func retrievedFeedsSuccessfully()
}

class NVMapViewController: UIViewController {
    var mapView: NVMapView?
    var interactor: NVMapInteractorInput?
    var router: NVMapRouterInput?

    var feedLocations = [NVTweetLocation]()

    // MARK: - Lifecycle Methods
    override func loadView() {
        super.loadView()
        view = mapView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        interactor?.loadTweets()
    }
}

extension NVMapViewController: NVMapViewControllerProtocol {
    func retrievedFeedsSuccessfully() {
//        mapView?.tweetMapView.addAnnotations(feedLocations)
        mapView?.tweetMapView.showAnnotations(feedLocations, animated: true)
    }
}
