//
//  NVDeleteRuleRequest.swift
//  NVTwitterDemo
//

import Foundation

class NVDeleteRuleRequest: NVApiRequestProtocol {
    let ruleIds: [String]

    init(with ruleIds: [String]) {
        self.ruleIds = ruleIds
    }

    func endPoint() -> String {
        NVConstants.rulesAPIEndPoint
    }

    func requestType() -> NVRequestFactory.Method {
        .POST
    }

    func bodyParams() -> [String: Any]? {
        let rules = [NVTwitterServiceConstants.RequestParamKeys.ids: ruleIds]
        let params = [NVTwitterServiceConstants.RequestParamKeys.delete: rules]
        return params
    }
}
