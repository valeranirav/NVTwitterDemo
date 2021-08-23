//
//  NVFetchTweetsRequest.swift
//  NVTwitterDemo
//

import Foundation

class NVConnectStreamRequest: NVApiRequestProtocol {
    func endPoint() -> String {
        NVConstants.connectStreamAPIEndPoint
    }

    func requestType() -> NVRequestFactory.Method {
        .GET
    }
}
