//
//  MenuViewController.swift
//  HammerSystemTestWork
//
//  Created by Ivan Lyaskovets on 22.06.2023.
//

import UIKit


/// Класс вью Menu  модуля
class MenuViewController: UIViewController {

	// MARK: - Private constants

	private enum Constants {
		// Colors
		static let mainBackgroundColor: UIColor = .white
		// Sizes
		static let heightForRow: CGFloat = 170
		static let menuHeaderViewHeight: CGFloat = 260
	}

	// MARK: - UI

	private var menuHeaderView: MenuHeaderView!

	private lazy var menuTableView: UITableView = {
		let tableView = UITableView(frame: .zero)
		tableView.backgroundColor = .white
		tableView.showsVerticalScrollIndicator = false
		tableView.register(FoodCell.self, forCellReuseIdentifier: FoodCell.indentifier)
		return tableView
	}()

	// MARK: - LifeCycleOfVC

	override func viewDidLoad() {
		super.viewDidLoad()
		setupView()
		menuTableView.delegate = self
		menuTableView.dataSource = self
	}
}

// MARK: - Private methods

extension MenuViewController {
	private func setupView() {
		view.backgroundColor = Constants.mainBackgroundColor
		setupHeaderView()
		view.addSubview(menuTableView)
		setupConstraits()
	}

	private func setupConstraits() {
		menuTableView.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			menuTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			menuTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			menuTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
			menuTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
		])
	}

	private func setupHeaderView() {
		let menuHeaderView = MenuHeaderView(frame: CGRect(origin: .zero, size: CGSize(width: view.bounds.width, height: Constants.menuHeaderViewHeight)))
		menuTableView.tableHeaderView = menuHeaderView
	}
}

// MARK: - UITableViewDataSource

extension MenuViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 10
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: FoodCell.indentifier, for: indexPath) as? FoodCell else {
			return UITableViewCell()
		}
		return cell
	}
}

// MARK: - UITableViewDelegate

extension MenuViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return Constants.heightForRow
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
	}
}

