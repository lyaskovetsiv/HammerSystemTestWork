//
//  MenuHeaderView.swift
//  HammerSystemTestWork
//
//  Created by Ivan Lyaskovets on 22.06.2023.
//

import UIKit


/// Класс headerView таблицы в Menu модуле
final class MenuHeaderView: UIView {

	// MARK: - Private constants

	private enum Constants {
		// Colors
		static let mainBackgroundColor: UIColor = #colorLiteral(red: 0.9487603307, green: 0.9565995336, blue: 0.9732769132, alpha: 1)
		// Sizes
		static let bannerCollecitonViewHeight: CGFloat = 112
		static let categoriesCollectionViewHeight: CGFloat = 32
		// Constraits
		static let bannerCollecitonViewTopAnchorConstant: CGFloat  = 25
		static let bannerCollecitonViewLeadingAnchorConstant: CGFloat  = 16
		static let categoriesCollectionViewTopAnchorConstant: CGFloat = 25
		static let categoriesCollectionViewLeadingAnchorConstant: CGFloat = 16
		static let categoriesCollectionViewBottomAnchorConstant: CGFloat = -24
	}

	// MARK: - UI

	private lazy var bannerCollecitonView: UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
		collectionView.backgroundColor = .green
		return collectionView
	}()

	private lazy var categoriesCollectionView: UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
		collectionView.backgroundColor = .red
		return collectionView
	}()

	private var categoriesCollectionViewTopAnchor: NSLayoutConstraint!
	private var bannersConstraits: [NSLayoutConstraint]!

	// MARK: - Inits

	override init(frame: CGRect) {
		super.init(frame: frame)
		setupView()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Public methods

	/// Метод вью, для изменения параметра alpha у bannersCollectionView
	/// - Parameter value: Значение alpha
	public func changeBannersCollectionViewAlpha(value: CGFloat) {
		bannerCollecitonView.alpha = value
	}

	/// Метод вью, для его сжатия и скрытия  bannersCollectionView
	public func compressMenuHeaderView() {
		// Удалить у banners констреиты
		NSLayoutConstraint.deactivate(bannersConstraits)
		// Пересчитать констреит у Categories
		categoriesCollectionViewTopAnchor?.isActive = false
		categoriesCollectionViewTopAnchor = categoriesCollectionView.topAnchor.constraint(equalTo: topAnchor,
																						  constant: Constants.categoriesCollectionViewTopAnchorConstant)
		categoriesCollectionViewTopAnchor?.isActive = true
	}

	/// Метод вью, для его разжатия и отображения bannersCollectionView
	public func uncompressMenuHeaderView() {
		// Добавить у banners констреиты
		NSLayoutConstraint.activate(bannersConstraits)
		// Пересчитать констреит у Categories
		categoriesCollectionViewTopAnchor?.isActive = false
		categoriesCollectionViewTopAnchor = categoriesCollectionView.topAnchor.constraint(equalTo: bannerCollecitonView.bottomAnchor,
																						  constant: Constants.categoriesCollectionViewTopAnchorConstant)
		categoriesCollectionViewTopAnchor?.isActive = true
	}
}

// MARK: - Private methods

extension MenuHeaderView {
	private func setupView() {
		backgroundColor = Constants.mainBackgroundColor
		addSubview(bannerCollecitonView)
		addSubview(categoriesCollectionView)
		setupConstraits()
	}

	private func setupConstraits() {
		// Banners
		bannerCollecitonView.translatesAutoresizingMaskIntoConstraints = false
		bannersConstraits = [
			bannerCollecitonView.topAnchor.constraint(equalTo: topAnchor,
													  constant: Constants.bannerCollecitonViewTopAnchorConstant),
			bannerCollecitonView.leadingAnchor.constraint(equalTo: leadingAnchor,
														  constant: Constants.bannerCollecitonViewLeadingAnchorConstant),
			bannerCollecitonView.trailingAnchor.constraint(equalTo: trailingAnchor),
			bannerCollecitonView.heightAnchor.constraint(equalToConstant: Constants.bannerCollecitonViewHeight)
		]
		NSLayoutConstraint.activate(bannersConstraits)
		// Categories
		categoriesCollectionView.translatesAutoresizingMaskIntoConstraints = false
		categoriesCollectionViewTopAnchor = categoriesCollectionView.topAnchor.constraint(equalTo: bannerCollecitonView.bottomAnchor,
																						  constant: Constants.categoriesCollectionViewTopAnchorConstant)
		NSLayoutConstraint.activate([
			categoriesCollectionViewTopAnchor,
			categoriesCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor,
															  constant: Constants.categoriesCollectionViewLeadingAnchorConstant),
			categoriesCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
			categoriesCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Constants.categoriesCollectionViewBottomAnchorConstant),
			categoriesCollectionView.heightAnchor.constraint(equalToConstant: Constants.categoriesCollectionViewHeight)
		])
	}
}
