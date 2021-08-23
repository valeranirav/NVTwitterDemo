//
//  NVTweetListViewController.swift
//  NVTwitterDemo
//

import UIKit

protocol NVTweetListViewControllerProtocol: AnyObject {
    var feeds: [NVTweetModel] { get set }

    func didRetrieveFeedsSuccessful()
    func didRetriveFeedsFailed(with errorDescription: String)
    func didSetRuleFailed(with errorDescription: String)
}

class NVTweetListViewController: UIViewController {
    var tweetListView: NVTweetListView?
    var interactor: NVTweetListInteractorInput?
    var router: NVTweetListRouterInput?

    var feeds = [NVTweetModel]()

    lazy var mapBarButtonItem: UIBarButtonItem = {
        let item = UIBarButtonItem(
            title: "Map View",
            style: .plain,
            target: self,
            action: #selector(mapBarButtonItemTapped)
        )
        return item
    }()

    // MARK: - Lifecycle Methods
    override func loadView() {
        super.loadView()
        view = tweetListView

        tweetListView?.searchBar.delegate = self
        tweetListView?.tableView.delegate = self
        tweetListView?.tableView.dataSource = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        tweetListView?.searchBar.becomeFirstResponder()
    }
}

// MARK: - Actions
extension NVTweetListViewController {
    @objc func mapBarButtonItemTapped() {
        router?.routeToMapView()
    }
}

// MARK: General Methods
extension NVTweetListViewController {
    private func setupUI() {
        title = "Tweets"
        navigationItem.rightBarButtonItem = mapBarButtonItem
    }
}

extension NVTweetListViewController: NVTweetListViewControllerProtocol {
    func didRetrieveFeedsSuccessful() {
        tweetListView?.reloadTweetTableView()
        tweetListView?.hideIndicator()
    }

    func didRetriveFeedsFailed(with errorDescription: String) {
        tweetListView?.hideIndicator()
        UIAlertController.showAlertWithOkButton(controller: self, strMessage: errorDescription, completion: nil)
    }

    func didSetRuleFailed(with errorDescription: String) {
        tweetListView?.hideIndicator()
        UIAlertController.showAlertWithOkButton(controller: self, strMessage: errorDescription, completion: nil)
    }
}

// MARK: - UITableView DataSource & Delegate
extension NVTweetListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        feeds.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NVTweetCell.identifier, for: indexPath) as? NVTweetCell
        cell?.tweetObject = feeds[indexPath.row]
        return cell ?? UITableViewCell()
    }
}

// MARK: - UISearchBarDelegate
extension NVTweetListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.searchTextField.text {
            searchBar.resignFirstResponder()
            feeds.removeAll()
            tweetListView?.reloadTweetTableView()
            interactor?.searchTweet(with: searchText)
            tweetListView?.showIndicator()
        }
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
