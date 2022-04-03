//
//  InfoLabel.swift
//  RandomImage
//
//  Created by Alexander Rogov on 03.04.2022.
//

import UIKit

class InfoLabel: UIView {

    // MARK: - Constants

    private enum Constants {
        static let space: CGFloat = 5
    }

    // MARK: - Properties

    var info: (title: String?, data: String?)? {
        didSet {
            setInfo()
        }
    }

    // MARK: - Components

    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return label
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .gray
        return label
    }()

    // MARK: - Lifecycle

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)

        addSubviews([infoLabel, titleLabel])

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            infoLabel.topAnchor.constraint(equalTo: topAnchor),
            infoLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            infoLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            infoLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: Constants.space),
            titleLabel.centerYAnchor.constraint(equalTo: infoLabel.centerYAnchor),
        ])
    }

    required init?(coder _: NSCoder) {
        fatalError("Shouldn't use this way")
    }

    func setInfo() {
        titleLabel.text = info?.title
        infoLabel.text = info?.data
    }
}
