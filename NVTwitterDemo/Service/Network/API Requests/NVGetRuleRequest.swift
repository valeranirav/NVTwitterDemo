//
//  NVGetRuleRequest.swift
//  NVTwitterDemo
//

import Foundation

class NVGetRuleRequest: NVApiRequestProtocol {
    func endPoint() -> String {
        NVConstants.rulesAPIEndPoint
    }

    func requestType() -> NVRequestFactory.Method {
        .GET
    }
}
