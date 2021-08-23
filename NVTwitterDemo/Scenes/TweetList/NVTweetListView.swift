//
//  NVTweetListView.swift
//  NVTwitterDemo
//

import UIKit

class NVTweetListView: UIView {
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Properties
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.placeholder = " Enter search keyword..."
        searchBar.isTranslucent = false
        searchBar.sizeToFit()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.estimatedRowHeight = 60
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(NVTweetCell.self, forCellReuseIdentifier: NVTweetCell.identifier)
        tableView.allowsMultipleSelection = true
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
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
extension NVTweetListView {
    func reloadTweetTableView() {
        tableView.reloadData()
    }

    func showIndicator() {
        activityIndicator.startAnimating()
    }

    func hideIndicator() {
        activityIndicator.stopAnimating()
    }
}

// MARK: - UI Setup
extension NVTweetListView {
    private func setupUI() {
        backgroundColor = .white

        addSubview(tableView)
        addSubview(activityIndicator)
        addSubview(searchBar)

        isUserInteractionEnabled = true

        NSLayoutConstraint.activate([
            searchBar.leftAnchor.constraint(equalTo: self.leftAnchor),
            searchBar.rightAnchor.constraint(equalTo: self.rightAnchor),
            searchBar.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            searchBar.heightAnchor.constraint(equalToConstant: 44)
        ])

        NSLayoutConstraint.activate([
            tableView.leftAnchor.constraint(equalTo: self.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: self.rightAnchor),
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])

        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            activityIndicator.widthAnchor.constraint(equalToConstant: 50),
            activityIndicator.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
