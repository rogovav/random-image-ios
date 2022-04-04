//
//  ImageCell.swift
//  RandomImage
//
//  Created by Alexander Rogov on 04.04.2022.
//

import UIKit

final class ImageCell: UITableViewCell {
    // MARK: - Properties

    var delegate: BookmarksDelegate?
    var imageId: String?

    // MARK: - Components

    private lazy var imageCard: ImageCard = {
        let card = ImageCard()
        card.translatesAutoresizingMaskIntoConstraints = false
        card.imageHeight = UIScreen.main.bounds.width - 40
        return card
    }()

    // MARK: - Lifecycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectionStyle = .none
        backgroundColor = .clear

        contentView.addSubview(imageCard)

        NSLayoutConstraint.activate([
            imageCard.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageCard.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageCard.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageCard.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
        ])

        imageCard.onBookmarkChange = { [weak self] in
            self?.delegate?.delete(self?.imageId)
        }
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }

    func getImage() {
        delegate?.getImage(imageId) { [weak self] model in
            self?.imageCard.model = model
        }
    }
}
