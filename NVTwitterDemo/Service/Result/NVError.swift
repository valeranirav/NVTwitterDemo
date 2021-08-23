//
//  NVError.swift
//  NVTwitterDemo
//

import Foundation

/** `NVError` is the error type result returned by App. It encompasses a few different types of errors, each with their own associated reasons.

    - network:  When error occurs because of network issue
    - parser:   When error occurs while parsing data
    - custom:   When error doesn't fall in either of the above error type
 */
enum NVError: Error {
    case network(string: String)
    case parser(string: String)
    case custom(string: String)

    func getErrorDescription() -> String {
        switch self {
        case .network(let errorDescription):
            return errorDescription
        case .parser(let errorDescription):
            return errorDescription
        case .custom(let errorDescription):
            return errorDescription
        }
    }
}
