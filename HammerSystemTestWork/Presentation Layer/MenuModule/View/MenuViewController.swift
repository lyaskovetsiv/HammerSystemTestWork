//
//  MenuViewController.swift
//  HammerSystemTestWork
//
//  Created by Ivan Lyaskovets on 22.06.2023.
//

import UIKit


/// Класс вью Menu  модуля
class MenuViewController: UIViewController {

	var presenter: IMenuPresenter?

	// MARK: - Private constants

	private enum Constants {
		// Colors
		static let mainBackgroundColor: UIColor = .white
		// Sizes
		static let heightForRow: CGFloat = 170
		static let menuHeaderViewHeight: CGFloat = 260
	}

	// MARK: - UI

	private var selectTownView: SelectTownView = {
		let view = SelectTownView()
		return view
	}()

	private var menuHeaderView: MenuHeaderView = {
		let view = MenuHeaderView()
		return view
	}()

	private lazy var menuTableView: UITableView = {
		let tableView = UITableView(frame: .zero)
		tableView.backgroundColor = .white
		tableView.showsVerticalScrollIndicator = false
		tableView.register(FoodCell.self, forCellReuseIdentifier: FoodCell.identifier)
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
		view.addSubview(selectTownView)
		view.addSubview(menuHeaderView)
		view.addSubview(menuTableView)
		setupConstraits()
	}

	private func setupConstraits() {
		selectTownView.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			selectTownView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			selectTownView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			selectTownView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
		])

		menuHeaderView.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			menuHeaderView.topAnchor.constraint(equalTo: selectTownView.bottomAnchor),
			menuHeaderView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			menuHeaderView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
		])

		menuTableView.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			menuTableView.topAnchor.constraint(equalTo: menuHeaderView.bottomAnchor),
			menuTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			menuTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			menuTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
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
		return presenter?.getNumberOfFoodItems() ?? 0
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: FoodCell.identifier, for: indexPath) as? FoodCell else {
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

	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		let y = scrollView.contentOffset.y
		let isSwipingDown = y <= 0
		let snappingAllowed = y > 1

		UIView.animate(withDuration: 0.3) {
			let value = isSwipingDown ? 1.0 : 0
			self.menuHeaderView.changeBannersCollectionViewAlpha(value: value)
		}

		UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.3, delay: 0) {
			if snappingAllowed {
				self.menuHeaderView.compressMenuHeaderView()
			} else {
				self.menuHeaderView.uncompressMenuHeaderView()
			}
			self.view.layoutIfNeeded()
		}
	}
}

// MARK: - IMenuView

extension MenuViewController: IMenuView {

}
