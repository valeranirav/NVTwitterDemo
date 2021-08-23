//
//  NVTweetCell.swift
//  NVTwitterDemo
//

import UIKit

class NVTweetCell: UITableViewCell {
    static let identifier = "nvTweetCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var tweetObject: NVTweetModel? {
        didSet {
            setContent()
        }
    }

    private let tweetLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}

// MARK: - UI Setup
extension NVTweetCell {
    private func setupUI() {
        self.backgroundColor = .white
        self.accessoryType = .none
        self.selectionStyle = .none

        contentView.addSubview(tweetLabel)

        NSLayoutConstraint.activate([
            tweetLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20),
            tweetLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20),
            tweetLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 20)
        ])

        contentView.widthAnchor.constraint(equalToConstant: (UIScreen.main.bounds.size.width)).isActive = true
        contentView.bottomAnchor.constraint(equalTo: tweetLabel.bottomAnchor, constant: 20).isActive = true
    }
}

// MARK: - General Methods
extension NVTweetCell {
    private func setContent() {
        tweetLabel.text = tweetObject?.text
    }
}
