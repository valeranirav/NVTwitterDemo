//
//  NVTweetListRouterMock.swift
//  NVTwitterDemoTests
//

import Foundation
@testable import NVTwitterDemo

class NVTweetListRouterMock: NVTweetListRouterInput {
    var routeToMapViewCalled = 0
    func routeToMapView() {
        routeToMapViewCalled += 1
    }
}
