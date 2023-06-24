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
		static let mainBackgroundColor: UIColor = #colorLiteral(red: 0.9487603307, green: 0.9565995336, blue: 0.9732769132, alpha: 1)
		static let separatorColor: UIColor = #colorLiteral(red: 0.9487603307, green: 0.9565995336, blue: 0.9732769132, alpha: 1)
		static let tableViewBackgroundColor: UIColor = .white
		// Sizes
		static let heightForRow: CGFloat = 170
		static let menuHeaderViewHeight: CGFloat = 260
		static let minimumInteritemSpacingForSection: CGFloat = 16
		static let sizeForCategoryCell: CGSize = CGSize(width: 95, height: 32)
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
		tableView.backgroundColor = Constants.tableViewBackgroundColor
		tableView.separatorStyle = .none
		tableView.showsVerticalScrollIndicator = false
		tableView.register(FoodCell.self, forCellReuseIdentifier: FoodCell.identifier)
		return tableView
	}()

	private var selectedCategoryIndexPath: IndexPath?

	// MARK: - LifeCycleOfVC

	override func viewDidLoad() {
		super.viewDidLoad()
		setupView()
		menuHeaderView.configureDataSourceAndDelegate(with: self)
		menuTableView.delegate = self
		menuTableView.dataSource = self
	}

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		presenter?.viewDidAppear()
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

	private func updateCellDesign(collectionView: UICollectionView, indexPath: IndexPath, selected: Bool) {
		if let cell = collectionView.cellForItem(at: indexPath) as? CategoryFoodCell {
			cell.updateDesign(selected: selected)
		}
	}

	private func processChangeCellUI(indexPath: IndexPath) {
		if let selectedIndexPath = selectedCategoryIndexPath {
			updateCellDesign(collectionView: menuHeaderView.categoriesCollectionView,
							 indexPath: selectedIndexPath,
							 selected: false)
		}
		updateCellDesign(collectionView: menuHeaderView.categoriesCollectionView,
						 indexPath: indexPath,
						 selected: true)
		selectedCategoryIndexPath = indexPath
	}

	private func createCustomSeparator() -> UIView {
		let separator = UIView(frame: CGRect(x: 0, y: 0, width: menuTableView.frame.width, height: 1.0))
		separator.backgroundColor = Constants.separatorColor
		return separator
	}

	private func hideAndSnapHeaderView(scrollView: UIScrollView) {
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

	private func changeAlphaForCell(scrollView: UIScrollView) {
		if let collectionView = scrollView as? UICollectionView {
			if collectionView == menuHeaderView.bannerCollectionView {
				let visibleRect = CGRect(origin: collectionView.contentOffset, size: collectionView.bounds.size)
				let visibleCells = collectionView.visibleCells
					for cell in visibleCells {
						if let indexPath = collectionView.indexPath(for: cell) {
							let cellRect = collectionView.layoutAttributesForItem(at: indexPath)?.frame ?? .zero
							let fullyVisible = visibleRect.contains(cellRect)
							UIView.animate(withDuration: 0.3) {
								cell.alpha = fullyVisible ? 1.0 : 0.5
							}
						}
					}
				}
			}
		}

	private func scrollForTableView(scrollView: UIScrollView) {
		guard menuTableView.isDragging else { return }
		let visibleIndexPath = menuTableView.indexPathsForVisibleRows ?? []
		guard let firstVisibleIndexPath = visibleIndexPath.first else {
			return
		}
		presenter?.tableViewDidScroll(indexPath: firstVisibleIndexPath)
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
		presenter?.foodDidTapped(by: indexPath)
	}

	func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
		if indexPath.row != tableView.numberOfRows(inSection: indexPath.section) - 1 {
			let separator = createCustomSeparator()
			cell.addSubview(separator)
			separator.translatesAutoresizingMaskIntoConstraints = false
			separator.leadingAnchor.constraint(equalTo: cell.leadingAnchor).isActive = true
			separator.trailingAnchor.constraint(equalTo: cell.trailingAnchor).isActive = true
			separator.bottomAnchor.constraint(equalTo: cell.bottomAnchor).isActive = true
			separator.heightAnchor.constraint(equalToConstant: 2).isActive = true
		}
	}

	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		changeAlphaForCell(scrollView: scrollView)
		hideAndSnapHeaderView(scrollView: scrollView)
		scrollForTableView(scrollView: scrollView)
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
			presenter?.bannerDidTapped(by: indexPath)
		case menuHeaderView.categoriesCollectionView:
			presenter?.categoryDidTapped(by: indexPath)
			processChangeCellUI(indexPath: indexPath)
		default: break
		}
	}
}

// MARK: - UICollectionViewDelegateFlowLayout

extension MenuViewController: UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		switch collectionView {
		case menuHeaderView.bannerCollectionView:
			return CGSize(width: 300, height: menuHeaderView.bannerCollectionView.bounds.height)
		case menuHeaderView.categoriesCollectionView:
			return Constants.sizeForCategoryCell
		default: break
		}
		return CGSize.zero
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
		return Constants.minimumInteritemSpacingForSection
	}

	func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
		if collectionView == menuHeaderView.bannerCollectionView {
			let visibleRect = CGRect(origin: collectionView.contentOffset, size: collectionView.bounds.size)
			let cellRect = collectionView.layoutAttributesForItem(at: indexPath)?.frame ?? .zero
			let fullyVisible = visibleRect.contains(cellRect)
			cell.alpha = fullyVisible ? 1.0 : 0.5
		}
	}
}

// MARK: - IMenuView

extension MenuViewController: IMenuView {
	/// Метод вью, отвечающий за перезагрузку UI
	public func reloadUI() {
		menuTableView.reloadData()
		menuHeaderView.bannerCollectionView.reloadData()
		menuHeaderView.categoriesCollectionView.reloadData()
	}

	/// Метод вью, отвечающий за скролинг таблицы в случае переключения категорий
	/// - Parameter indexPath: Индекс ячейки
	public func scrollTableViewTo(indexPath: IndexPath) {
		menuTableView.scrollToRow(at: indexPath, at: .top, animated: true)
	}

	/// Метод вью, отвечающий за выделение ячейки с категорией при скроллинге таблицы
	/// - Parameter indexPath: Индекс ячейки
	public func selectCellFromCollectionView(indexPath: IndexPath) {
		processChangeCellUI(indexPath: indexPath)
	}
}
