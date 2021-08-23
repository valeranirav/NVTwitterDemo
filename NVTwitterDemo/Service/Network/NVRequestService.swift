//
//  NVRequestService.swift
//  NVTwitterDemo
//

import Foundation

/// Closure alias
typealias ResponseClosure = (Result<Data, NVError>) -> Void

/// `NVRequestService` is a concrete service class for requesting data from the server

final class NVRequestService: NSObject {
    private var responseClosure: ResponseClosure?

    let dispatchQueue = DispatchQueue(label: "com.twitterdemo.background", attributes: [])
    private(set) lazy var session: Foundation.URLSession = {
        let operationQueue = OperationQueue()
        operationQueue.underlyingQueue = self.dispatchQueue
        let configuration = URLSessionConfiguration.default
        return Foundation.URLSession(configuration: configuration, delegate: self, delegateQueue: operationQueue)
    }()

    /**
     Creates an `URLSessionTask` with the specified url string and session.
     
     - parameter request:    URLRequest that will be used to request data from server
     - parameter session:     URLSession which will be used to create URLDataTask
     - parameter completion:  A closure to be executed once the task finishes. This closure takes one argument: the server response as NVResult enum
     
     - Returns: URLSessionTask object
     */

    func loadData(
        request: URLRequest,
        session: URLSession = URLSession(configuration: .default),
        completion: @escaping (Result<Data, NVError>) -> Void
    ) -> URLSessionTask {
        let task = session.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print("error: \(error)")
                completion(.failure(.network(string: "An error occured during request :" + error.localizedDescription)))
                return
            }

            if let data = data {
                print("Data: \(data)")
                completion(.success(data))
            }
        }
        task.resume()
        return task
    }

    func connect(
        request: URLRequest,
        completion: @escaping ResponseClosure
    ) -> URLSessionTask {
        responseClosure = completion
        let task = session.dataTask(with: request)
        task.resume()
        return task
    }
}

extension NVRequestService: URLSessionDataDelegate {
    func urlSession(
        _ session: URLSession,
        dataTask: URLSessionDataTask,
        didReceive response: URLResponse,
        completionHandler: @escaping (URLSession.ResponseDisposition) -> Void
    ) {
        completionHandler(dataTask.state != .canceling ? .allow : .cancel)
    }

    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        if dataTask.state != .canceling {
            self.responseClosure?(.success(data))
        }
    }

    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        if let error = error, error.localizedDescription != "cancelled" {
            self.responseClosure?(.failure(.network(string: error.localizedDescription)))
        }
    }
}
