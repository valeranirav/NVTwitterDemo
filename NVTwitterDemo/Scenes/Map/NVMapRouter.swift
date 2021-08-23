//
//  NVMapRouter.swift
//  NVTwitterDemo
//

import Foundation
import UIKit

protocol NVMapRouterInput: AnyObject {

}

final class NVMapRouter {
    weak var source: UIViewController?

    init(source: UIViewController) {
        self.source = source
    }
}

extension NVMapRouter: NVMapRouterInput {

}
