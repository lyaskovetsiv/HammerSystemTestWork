//
//  MenuHeaderView.swift
//  HammerSystemTestWork
//
//  Created by Ivan Lyaskovets on 22.06.2023.
//

import UIKit


/// Класс  вью с категориями блюд и акциями в Menu модуле
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

	weak var delegate: MenuHeaderViewDelegate?

	// MARK: - UI

	private(set) lazy var bannerCollectionView: UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .horizontal
		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
		collectionView.showsHorizontalScrollIndicator = false
		collectionView.register(BannerCell.self, forCellWithReuseIdentifier: BannerCell.identifier)
		collectionView.backgroundColor = .clear
		return collectionView
	}()

	private(set) lazy var categoriesCollectionView: UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .horizontal
		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
		collectionView.register(CategoryFoodCell.self, forCellWithReuseIdentifier: CategoryFoodCell.identifier)
		collectionView.showsHorizontalScrollIndicator = false
		collectionView.backgroundColor = .clear
		collectionView.isUserInteractionEnabled = true
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
		bannerCollectionView.alpha = value
	}

	/// Метод вью, для его сжатия и скрытия  bannersCollectionView
	public func compressMenuHeaderView() {
		// Удалить у banners констреиты
		NSLayoutConstraint.deactivate(bannersConstraits)
		// Пересчитать констреит у Categories
		categoriesCollectionViewTopAnchor?.isActive = false
		categoriesCollectionViewTopAnchor = categoriesCollectionView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.categoriesCollectionViewTopAnchorConstant)
		categoriesCollectionViewTopAnchor?.isActive = true
	}

	/// Метод вью, для его разжатия и отображения bannersCollectionView
	public func uncompressMenuHeaderView() {
		// Добавить у banners констреиты
		NSLayoutConstraint.activate(bannersConstraits)
		// Пересчитать констреит у Categories
		categoriesCollectionViewTopAnchor?.isActive = false
		categoriesCollectionViewTopAnchor = categoriesCollectionView.topAnchor.constraint(equalTo: bannerCollectionView.bottomAnchor,constant: Constants.categoriesCollectionViewTopAnchorConstant)
		categoriesCollectionViewTopAnchor?.isActive = true
	}

	public func configureDataSourceAndDelegate(with vc: UICollectionViewDataSource&UICollectionViewDelegate) {
		bannerCollectionView.dataSource = vc
		bannerCollectionView.delegate = vc
		categoriesCollectionView.dataSource = vc
		categoriesCollectionView.delegate = vc
	}
}

// MARK: - Private methods

extension MenuHeaderView {
	private func setupView() {
		backgroundColor = Constants.mainBackgroundColor
		addSubview(bannerCollectionView)
		addSubview(categoriesCollectionView)
		setupConstraits()
	}

	private func setupConstraits() {
		// Banners
		bannerCollectionView.translatesAutoresizingMaskIntoConstraints = false
		bannersConstraits = [
			bannerCollectionView.topAnchor.constraint(equalTo: topAnchor,
													  constant: Constants.bannerCollecitonViewTopAnchorConstant),
			bannerCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor,
														  constant: Constants.bannerCollecitonViewLeadingAnchorConstant),
			bannerCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
			bannerCollectionView.heightAnchor.constraint(equalToConstant: Constants.bannerCollecitonViewHeight)
		]
		NSLayoutConstraint.activate(bannersConstraits)
		// Categories
		categoriesCollectionView.translatesAutoresizingMaskIntoConstraints = false
		categoriesCollectionViewTopAnchor = categoriesCollectionView.topAnchor.constraint(equalTo: bannerCollectionView.bottomAnchor,
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
