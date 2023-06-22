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
		static let minimumInteritemSpacingForSection: CGFloat = 16
		static let sizeForBannerCell: CGSize = CGSize(width: 300, height: 122)
		static let suzeForCategoryCell: CGSize = CGSize(width: 95, height: 32)
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
		menuHeaderView.configureDataSourceAndDelegate(with: self)
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
		if let model = presenter?.getFood(by: indexPath) {
			cell.configure(with: model)
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
		if let model = presenter?.getFood(by: indexPath) {
			print("В корзину добавлен товар: \(model.title)")
		}
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

// MARK: - UICollectionViewDataSource

extension MenuViewController: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		if collectionView == menuHeaderView.bannerCollectionView {
			return presenter?.getNumberOfPromo() ?? 0
		} else if collectionView == menuHeaderView.categoriesCollectionView {
			return presenter?.getNumberOfCategories() ?? 0
		}
		return 0
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		switch collectionView {
		case menuHeaderView.bannerCollectionView:
			guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerCell.identifier, for: indexPath) as? BannerCell else {
				return UICollectionViewCell()
			}
			if let model = presenter?.getPromo(by: indexPath) {
				cell.configure(with: model)
			}
			return cell
		case menuHeaderView.categoriesCollectionView:
			guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryFoodCell.identifier, for: indexPath) as? CategoryFoodCell else {
				return UICollectionViewCell()
			}
			if let model = presenter?.getCategory(by: indexPath) {
				cell.configure(with: model)
			}
			return cell
		default: break
		}
		return UICollectionViewCell()
	}
}

// MARK: - UICollectionViewDelegate

extension MenuViewController: UICollectionViewDelegate {
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		switch collectionView {
		case menuHeaderView.bannerCollectionView:
			if let model = presenter?.getPromo(by: indexPath) {
				print("Выбрана акция: \(model.title)")
			}
		case menuHeaderView.categoriesCollectionView:
			if let model = presenter?.getCategory(by: indexPath) {
				print("Выбрана категория: \(model.title)")
			}
		default: break
		}
	}
}

// MARK: - UICollectionViewDelegateFlowLayout

extension MenuViewController: UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		switch collectionView {
		case menuHeaderView.bannerCollectionView:
			return Constants.sizeForBannerCell
		case menuHeaderView.categoriesCollectionView:
			return Constants.suzeForCategoryCell
		default: break
		}
		return CGSize.zero
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
		return Constants.minimumInteritemSpacingForSection
	}
}

// MARK: - IMenuView

extension MenuViewController: IMenuView {

}
