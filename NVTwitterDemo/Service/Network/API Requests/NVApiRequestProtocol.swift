//
//  NVApiRequest.swift
//  NVTwitterDemo
//

import Foundation

protocol NVApiRequestProtocol {
    func baseUrl() -> String
    func endPoint() -> String
    func bodyParams() -> [String: Any]?
    func requestType() -> NVRequestFactory.Method
    func contentType() -> String
    func bearerToken() -> String
}

extension NVApiRequestProtocol {
    func baseUrl() -> String {
        NVConstants.streamAPIBaseURLString
    }

    func contentType() -> String {
        "application/json"
    }

    func bearerToken() -> String {
        NVConstants.bearerToken
    }

    func bodyParams() -> [String: Any]? {
        nil
    }
}
