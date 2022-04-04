//
//  BookmarksVC.swift
//  RandomImage
//
//  Created by Alexander Rogov on 03.04.2022.
//

import UIKit

final class BookmarksVC: UIViewController {
    // MARK: - Constants

    private enum Constants {
        static let defaultMargin: CGFloat = 20
        static let timerToText: CGFloat = 10
    }

    // MARK: - Properties

    private var items: [String] = []

    private let viewModel: BookmarksViewModel?

    // MARK: - Components

    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.separatorStyle = .none
        table.alwaysBounceHorizontal = false
        table.showsVerticalScrollIndicator = false
        table.backgroundColor = .clear
        table.register(ImageCell.self, forCellReuseIdentifier: "ImageCell")
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()

    private lazy var noSignalView: NoSignalView = {
        let view = NoSignalView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // MARK: - Lifecycle
    init(_ viewModel: BookmarksViewModel) {
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
        navigationController!.navigationBar.isHidden = true
        setViews()
        getItems()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getItems()
    }

    private func setViews() {
        view.backgroundColor = .white

        view.addSubviews([tableView, noSignalView])

        let guide = view.safeAreaLayoutGuide

        noSignalView.isHidden = true

        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.defaultMargin),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.defaultMargin),
            tableView.topAnchor.constraint(equalTo: guide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: guide.bottomAnchor),
        ])

        NSLayoutConstraint.activate([
            noSignalView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            noSignalView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])

        tableView.delegate = self
        tableView.dataSource = self
    }

    private func bookmarkAction(_ id: String?) {
        guard let id = id else {
            return
        }
        viewModel?.updateBookmark(id)
    }

    private func getItems() {
        viewModel?.getItems(completion: { [weak self] items in
            guard let self = self else {
                return
            }
            self.items = items
            self.tableView.reloadData()
        })
    }
}

// MARK: - UITableViewDelegate

extension BookmarksVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: ImageCell = tableView.dequeueReusableCell(withIdentifier: "ImageCell", for: indexPath as IndexPath) as? ImageCell else {
            return UITableViewCell()
        }
        cell.delegate = self
        cell.imageId = items[indexPath.row]
        cell.getImage()
        return cell
    }
}

// MARK: - BookmarksDelegate

extension BookmarksVC: BookmarksDelegate {
    func delete(_ id: String?) {
        guard let id = id else {
            return
        }
        viewModel?.updateBookmark(id)
        getItems()
    }

    func getImage(_ id: String?, completion: ((ImageCardModel?) -> Void)?) {
        guard let id = id else {
            return
        }
        viewModel?.getImage(id) { [weak self] model, notConnected in
            if notConnected {
                self?.noSignalView.isHidden = false
            } else {
                completion?(model)
                self?.noSignalView.isHidden = true
            }
        }
    }
}
