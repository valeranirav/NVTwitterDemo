//
//  NVRequestFactory.swift
//  NVTwitterDemo
//

import Foundation
/// `NVRequestFactory` creates a request based on the information passed

final class NVRequestFactory {
    /// `Method` is the method type returned by app.
    enum Method: String {
        case GET
        case POST
        case PUT
        case DELETE
    }

    /**
     Responsible for creating URLRequest
 
     - parameter api: Represents model for request
     
     - Returns: URLRequest object
    */

    static func request(for api: NVApiRequestProtocol) -> URLRequest? {
        let completeUrlString = api.baseUrl() + api.endPoint()
        guard let url = URL(string: completeUrlString) else {
            return nil
        }

        var request = URLRequest(url: url)
        request.httpMethod = api.requestType().rawValue
        request.addValue(api.contentType(), forHTTPHeaderField: "Content-type")
        request.addValue(api.bearerToken(), forHTTPHeaderField: "Authorization")

        if let reachability = Reachability(), !reachability.isReachable {
            request.cachePolicy = .returnCacheDataDontLoad
        }

        print("Request: \(request)")

        if let parameters = api.bodyParams() {
            do {
                request.httpBody = try JSONSerialization.data(
                    withJSONObject: parameters as Any,
                    options: .prettyPrinted
                )
            } catch let error {
                print(error.localizedDescription)
            }
        }
        return request
    }
}
