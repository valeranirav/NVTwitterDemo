//
//  FileManager+Utilities.swift
//  NVTwitterDemo
//
//

import Foundation

extension FileManager {
    static func readJson(forResource fileName: String) -> Data? {
        let bundle = Bundle.main
        if let path = bundle.path(forResource: fileName, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                return data
            } catch {
                print("Error in reading data from JSON: \(error.localizedDescription)")
            }
        }

        return nil
    }
}
