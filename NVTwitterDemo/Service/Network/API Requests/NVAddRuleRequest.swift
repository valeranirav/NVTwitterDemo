//
//  NVAddRuleRequest.swift
//  NVTwitterDemo
//

import Foundation

class NVAddRuleRequest: NVApiRequestProtocol {
    let keyword: String

    init(with keyword: String) {
        self.keyword = keyword
    }

    func endPoint() -> String {
        NVConstants.rulesAPIEndPoint
    }

    func requestType() -> NVRequestFactory.Method {
        .POST
    }

    func bodyParams() -> [String: Any]? {
        let ruleValue = "\(keyword) \(NVTwitterServiceConstants.RequestParamValues.sample):1"
        let tagValue = "\(keyword) text"
        let rules = [
            [
                NVTwitterServiceConstants.RequestParamKeys.value: ruleValue,
                NVTwitterServiceConstants.RequestParamKeys.tag: tagValue
            ]
        ]
        let params = [NVTwitterServiceConstants.RequestParamKeys.add: rules]
        return params
    }
}
