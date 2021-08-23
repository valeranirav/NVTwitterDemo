//
//  NVTweetLocation.swift
//  NVTwitterDemo
//

import MapKit
import UIKit

class NVTweetLocation: NSObject, MKAnnotation {
    let title: String?
    let coordinate: CLLocationCoordinate2D

    init(title: String?, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.coordinate = coordinate
    }
}
