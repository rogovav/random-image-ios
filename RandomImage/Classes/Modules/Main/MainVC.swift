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
        static let timerToText: CGFloat = 10
    }

    // MARK: - Properties

    private var timer: Timer?
    private let initialTime: Int = 60
    private var timeToUpdate: Int = 0

    private let viewModel: MainViewModel?

    // MARK: - Components

    private lazy var imageCard: ImageCard = {
        let card = ImageCard()
        card.translatesAutoresizingMaskIntoConstraints = false
        card.imageHeight = UIScreen.main.bounds.width - Constants.defaultMargin * 2
        return card
    }()

    private lazy var timerInfo: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        label.textColor = .gray
        return label
    }()

    private lazy var timerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .gray
        label.text = "Next through"
        return label
    }()

    private lazy var timerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
    }()

    // MARK: - Lifecycle
    init(_ viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    override init(nibName nibNameOrNil: String? = nil, bundle nibBundleOrNil: Bundle? = nil) {
        viewModel = nil
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init?(coder: NSCoder) {
        viewModel = nil
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
        getImage()
    }

    private func setViews() {
        view.backgroundColor = .white

        timerView.addSubviews([timerLabel, timerInfo])

        view.addSubviews([imageCard, timerView])

        let guide = view.safeAreaLayoutGuide

        NSLayoutConstraint.activate([
            imageCard.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.defaultMargin),
            imageCard.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.defaultMargin),
            imageCard.topAnchor.constraint(equalTo: guide.topAnchor),
        ])

        NSLayoutConstraint.activate([
            timerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.defaultMargin),
            timerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.defaultMargin),
            timerView.bottomAnchor.constraint(equalTo: guide.bottomAnchor),
            timerView.topAnchor.constraint(equalTo: imageCard.bottomAnchor),
        ])

        NSLayoutConstraint.activate([
            timerLabel.centerXAnchor.constraint(equalTo: timerView.centerXAnchor),
            timerLabel.centerYAnchor.constraint(equalTo: timerView.centerYAnchor),
        ])

        NSLayoutConstraint.activate([
            timerInfo.topAnchor.constraint(equalTo: timerLabel.bottomAnchor, constant: Constants.timerToText),
            timerInfo.centerXAnchor.constraint(equalTo: timerView.centerXAnchor),
        ])
    }

    private func bookmarkAction(_ id: String?, isActive: Bool) {
        guard let id = id else { return }
        isActive ? viewModel?.deleteBookmark(id) : viewModel?.addBookmark(id)
    }

    private func getImage() {
        viewModel?.getImage(completion: { [weak self] model in
            guard let self = self else { return }
            self.imageCard.model = model
            self.imageCard.onBookmarkChange = { [weak self] isActive in
                self?.bookmarkAction(model?.id, isActive: isActive)
            }
            self.startTimer()
        })
    }

    private func startTimer() {
        guard timer == nil else {
            return
        }

        timeToUpdate = initialTime

        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            self?.updateLabel()
        }
    }

    private func stopTimer() {
        timer?.invalidate()
        timer = nil
        timerView.isHidden = true
    }

    @objc private func updateLabel() {
        timerView.isHidden = false
        timeToUpdate -= 1
        let minutes = timeToUpdate / 60
        let seconds = timeToUpdate % 60
        timerInfo.text = String(format: "%02d:%02d", minutes, seconds)
        if timeToUpdate == 0 {
            stopTimer()
            getImage()
        }
    }
}
