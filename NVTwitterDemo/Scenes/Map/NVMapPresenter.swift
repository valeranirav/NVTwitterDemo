//
//  NVMapPresenter.swift
//  NVTwitterDemo
//

import Foundation
import MapKit

protocol NVMapPresenterInput: AnyObject {
    func didRetrieveFeeds(_ searchedFeeds: [NVFeedResponseModel])
    func retrieveFeedsDidFailed(_ error: NVError)
}

final class NVMapPresenter {
    weak var viewController: NVMapViewControllerProtocol?

    init(viewController: NVMapViewControllerProtocol) {
        self.viewController = viewController
    }

    private func configureFeedLocations(with searchedFeeds: [NVFeedResponseModel]) -> [NVTweetLocation] {
        let locations = searchedFeeds.map { feedResponse -> NVTweetLocation? in
            let feed = feedResponse.feed
            if let coordinates = feed.geo?.coordinates, coordinates.count > 1 {
                let lat = coordinates[0]
                let long = coordinates[1]
                let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
                let location = NVTweetLocation(title: feed.text ?? "", coordinate: coordinate)
                return location
            }
            return nil
        }.compactMap { $0 }
        return locations
    }
}

extension NVMapPresenter: NVMapPresenterInput {
    func didRetrieveFeeds(_ searchedFeeds: [NVFeedResponseModel]) {
        let locations = configureFeedLocations(with: searchedFeeds)

        viewController?.feedLocations.append(contentsOf: locations)
        DispatchQueue.main.async {
            self.viewController?.retrievedFeedsSuccessfully()
        }
    }

    func retrieveFeedsDidFailed(_ error: NVError) {

    }
}
