//
//  ImageInfoView.swift
//  RandomImage
//
//  Created by Alexander Rogov on 03.04.2022.
//

import UIKit

class ImageInfoView: UIView {

    // MARK: - Constants

    private enum Constants {
        static let space: CGFloat = 10
    }

    // MARK: - Properties

    var model: UnsplashImage? {
        didSet {
            guard let _ = model else {
                return
            }
            setInfo()
        }
    }

    // MARK: - Components

    private lazy var viewsInfo: InfoLabel = {
        let label = InfoLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var likesInfo: InfoLabel = {
        let label = InfoLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var downloadsInfo: InfoLabel = {
        let label = InfoLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Lifecycle

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)

//        addSubviews([viewsInfo])
        addSubviews([viewsInfo, likesInfo, downloadsInfo])

        NSLayoutConstraint.activate([
            viewsInfo.leadingAnchor.constraint(equalTo: leadingAnchor),
            viewsInfo.topAnchor.constraint(equalTo: topAnchor),
        ])

        NSLayoutConstraint.activate([
            likesInfo.leadingAnchor.constraint(equalTo: leadingAnchor),
            likesInfo.topAnchor.constraint(equalTo: viewsInfo.bottomAnchor, constant: Constants.space),
        ])

        NSLayoutConstraint.activate([
            downloadsInfo.leadingAnchor.constraint(equalTo: leadingAnchor),
            downloadsInfo.topAnchor.constraint(equalTo: likesInfo.bottomAnchor, constant: Constants.space),
            downloadsInfo.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }

    required init?(coder _: NSCoder) {
        fatalError("Shouldn't use this way")
    }

    func setInfo() {
        viewsInfo.info = ("Views:", "\(model?.views ?? 0)")
        likesInfo.info = ("Likes:", "\(model?.likes ?? 0)")
        downloadsInfo.info = ("Downloads:", "\(model?.downloads ?? 0)")
    }
}
