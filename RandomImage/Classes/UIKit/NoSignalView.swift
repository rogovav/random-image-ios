//
//  NoSignalView.swift
//  RandomImage
//
//  Created by Alexander Rogov on 04.04.2022.
//

import UIKit

class NoSignalView: UIView {

    // MARK: - Constants

    private enum Constants {
        static let space: CGFloat = 5
    }

    // MARK: - Components

    private lazy var iconView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "no-signal-icon")
        imageView.translatesAutoresizingMaskIntoConstraints = false;
        return imageView
    }()

    private lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "No internet"
        return label
    }()

    // MARK: - Lifecycle

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)

        addSubviews([iconView, label])

        NSLayoutConstraint.activate([
            iconView.centerXAnchor.constraint(equalTo: centerXAnchor),
            iconView.centerYAnchor.constraint(equalTo: topAnchor),

            iconView.heightAnchor.constraint(equalToConstant: 100),
            iconView.widthAnchor.constraint(equalToConstant: 100),

            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            label.topAnchor.constraint(equalTo: iconView.bottomAnchor, constant: 30),
        ])
    }

    required init?(coder _: NSCoder) {
        fatalError("Shouldn't use this way")
    }
}
