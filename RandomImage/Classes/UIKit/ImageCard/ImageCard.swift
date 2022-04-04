//
//  ImageCard.swift
//  RandomImage
//
//  Created by Alexander Rogov on 03.04.2022.
//

import UIKit

class ImageCard: UIView {
// MARK: - Constants

    private enum Constants {
        static let spacing: CGFloat = 10
        static let buttonSize: CGFloat = 30
        static let userInfoHeight: CGFloat = 40
    }

    // MARK: - Properties

    private var isActive: Bool = false

    var imageHeight: CGFloat?

    var onBookmarkChange: (() -> Void)?

    var model: ImageCardModel? {
        didSet {
            if model == nil {
                return
            }
            updateView()
        }
    }

    // MARK: - Components

    private let bookmarkImage = UIImage(named: "bookmark-icon")

    private let bookmarkImageActive = UIImage(named: "bookmark-active-icon")

    private lazy var imageBox: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false;
        return imageView
    }()

    private lazy var imageInfo: ImageInfoView = {
        let label = ImageInfoView()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var userInfo: UserInfoView = {
        let userView = UserInfoView()
        userView.translatesAutoresizingMaskIntoConstraints = false
        return userView
    }()

    private lazy var bookmarkButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(bookmarkImage, for: .normal)
        return button
    }()

    // MARK: - Lifecycle

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)

        addSubviews([userInfo, imageBox, imageInfo, bookmarkButton])

        bookmarkButton.addTarget(self, action: #selector(bookmarkAction), for: .touchUpInside)

        NSLayoutConstraint.activate([
            userInfo.topAnchor.constraint(equalTo: topAnchor),
            userInfo.leadingAnchor.constraint(equalTo: leadingAnchor),
            userInfo.heightAnchor.constraint(equalToConstant: Constants.userInfoHeight)
        ])

        NSLayoutConstraint.activate([
            bookmarkButton.leadingAnchor.constraint(equalTo: userInfo.trailingAnchor, constant: Constants.spacing),
            bookmarkButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            bookmarkButton.centerYAnchor.constraint(equalTo: userInfo.centerYAnchor),
            bookmarkButton.heightAnchor.constraint(equalToConstant: Constants.buttonSize),
            bookmarkButton.widthAnchor.constraint(equalToConstant: Constants.buttonSize),
        ])

        NSLayoutConstraint.activate([
            imageBox.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageBox.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageBox.topAnchor.constraint(equalTo: userInfo.bottomAnchor, constant: Constants.spacing),
            imageBox.heightAnchor.constraint(equalToConstant: imageHeight ?? UIScreen.main.bounds.width),
        ])

        NSLayoutConstraint.activate([
            imageInfo.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageInfo.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageInfo.topAnchor.constraint(equalTo: imageBox.bottomAnchor, constant: Constants.spacing),
            imageInfo.heightAnchor.constraint(equalToConstant: 80),
            imageInfo.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.spacing),
        ])
    }

    required init?(coder _: NSCoder) {
        fatalError("Shouldn't use this way")
    }

    @objc func bookmarkAction() {
        isActive.toggle()
        bookmarkButton.setImage(isActive ? bookmarkImageActive : bookmarkImage, for: .normal)
        onBookmarkChange?()
    }

    func updateView() {
        imageInfo.model = model?.imageInfo
        userInfo.model = model?.userInfo
        isActive = model?.isBookmark ?? false
        bookmarkButton.setImage(isActive ? bookmarkImageActive : bookmarkImage, for: .normal)
        if let imageData = model?.image {
            imageBox.image = UIImage(data: imageData)
        }
    }
}
