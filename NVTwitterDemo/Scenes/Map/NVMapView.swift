//
//  NVMapView.swift
//  NVTwitterDemo
//

import Foundation
import UIKit
import MapKit

class NVMapView: UIView {
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Properties
    lazy var tweetMapView: MKMapView = {
        let tweetMapView = MKMapView(frame: .zero)
        tweetMapView.translatesAutoresizingMaskIntoConstraints = false
        return tweetMapView
    }()

    lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .black
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
}

// MARK: - General Methods
extension NVMapView {
    func showIndicator() {
        activityIndicator.startAnimating()
    }

    func hideIndicator() {
        activityIndicator.stopAnimating()
    }
}

// MARK: - UI Setup
extension NVMapView {
    private func setupUI() {
        self.backgroundColor = .white

        addSubview(tweetMapView)
        addSubview(activityIndicator)

        NSLayoutConstraint.activate([
            tweetMapView.leftAnchor.constraint(equalTo: self.leftAnchor),
            tweetMapView.rightAnchor.constraint(equalTo: self.rightAnchor),
            tweetMapView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            tweetMapView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])

        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            activityIndicator.widthAnchor.constraint(equalToConstant: 50),
            activityIndicator.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
