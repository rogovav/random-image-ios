//
//  UserInfoView.swift
//  RandomImage
//
//  Created by Alexander Rogov on 03.04.2022.
//

import UIKit

class UserInfoView: UIView {

    // MARK: - Constants

    private enum Constants {
        static let imageSize: CGFloat = 40
        static let imageToText: CGFloat = 10
    }

    // MARK: - Properties

    var model: UserInfoModel? {
        didSet {
            guard let _ = model else {
                return
            }
            setInfo()
        }
    }

    // MARK: - Components

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return label
    }()

    private lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .light)
        label.textColor = .gray
        return label
    }()

    private lazy var profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.gray.withAlphaComponent(0.5).cgColor
        imageView.layer.cornerRadius = Constants.imageSize / 2
        imageView.clipsToBounds = true
        imageView.backgroundColor = .white
        return imageView
    }()

    // MARK: - Lifecycle

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)

        let nameView = UIView()
        nameView.translatesAutoresizingMaskIntoConstraints = false

        nameView.addSubviews([nameLabel, userNameLabel])

        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: nameView.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: nameView.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: nameView.trailingAnchor),
        ])

        NSLayoutConstraint.activate([
            userNameLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            userNameLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            userNameLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            userNameLabel.bottomAnchor.constraint(equalTo: nameView.bottomAnchor),
        ])

        addSubviews([profileImage, nameView])

        NSLayoutConstraint.activate([
            profileImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            profileImage.topAnchor.constraint(equalTo: topAnchor),
            profileImage.heightAnchor.constraint(equalToConstant: Constants.imageSize),
            profileImage.widthAnchor.constraint(equalToConstant: Constants.imageSize),
        ])

        NSLayoutConstraint.activate([
            nameView.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: Constants.imageToText),
            nameView.centerYAnchor.constraint(equalTo: profileImage.centerYAnchor),
        ])
    }

    required init?(coder _: NSCoder) {
        fatalError("Shouldn't use this way")
    }

    private func setInfo() {
        if let imageData = model?.image {
            profileImage.image = UIImage(data: imageData)
        }
        nameLabel.text = model?.name
        userNameLabel.text = "@\(model?.userName ?? "")"
    }
}
