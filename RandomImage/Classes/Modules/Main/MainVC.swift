//
//  MainVC.swift
//  RandomImage
//
//  Created by Alexander Rogov on 03.04.2022.
//

import UIKit

final class MainVC: UIViewController {
    // MARK: - Constants

    private enum Constants {
        static let defaultMargin: CGFloat = 20
    }

    // MARK: - Properties

//    private var viewModel: ProductViewModel

    // MARK: - Components

    let imageCard: ImageCard = {
        let card = ImageCard()
        card.translatesAutoresizingMaskIntoConstraints = false
        card.imageHeight = UIScreen.main.bounds.width - Constants.defaultMargin * 2
        return card
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        view.addSubviews([imageCard])

        let guide = view.safeAreaLayoutGuide

        NSLayoutConstraint.activate([
            imageCard.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.defaultMargin),
            imageCard.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.defaultMargin),
            imageCard.topAnchor.constraint(equalTo: guide.topAnchor),
        ])

        getRandomImage()
    }

    func bookmarkAction(_ id: String?, isActive: Bool) {
        print("\(id ?? ""): \(isActive)")
    }

    func getRandomImage() {
        UnsplashService.shared.getPhoto("random") { [weak self] image, error in
            if error == nil {
                guard let image = image else {
                    return
                }
                guard let self = self else {
                    return
                }
                self.imageCard.imageData = image
                self.imageCard.onBookmarkChange = { [weak self] isActive in
                    self?.bookmarkAction(image.id, isActive: isActive)
                }
            }
        }
    }
}
