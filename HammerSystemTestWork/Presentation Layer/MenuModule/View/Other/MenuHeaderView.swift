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
		// Fonts
		static let mainTextFont: UIFont = .systemFont(ofSize: 17)
		// Colors
		static let mainBackgroundColor: UIColor = #colorLiteral(red: 0.9487603307, green: 0.9565995336, blue: 0.9732769132, alpha: 1)
		// Sizes
		static let selectedTownSpacing: CGFloat = 8
		static let bannerCollecitonViewHeight: CGFloat = 112
		static let categoriesCollectionViewHeight: CGFloat = 32
		// Images
		static let downArrowImage: UIImage? = UIImage(named: "downArrayIcon")
		// Constraits
		static let selectTownStackViewTopAnchorConstant: CGFloat = 16
		static let selectTownStackViewLeadingAnchorConstant: CGFloat = 16
		static let bannerCollecitonViewTopAnchorConstant: CGFloat  = 25
		static let bannerCollecitonViewLeadingAnchorConstant: CGFloat  = 16
		static let categoriesCollectionViewTopAnchorConstant: CGFloat = 25
		static let categoriesCollectionViewLeadingAnchorConstant: CGFloat = 16
	}

	// MARK: - UI

	private lazy var townLabel: UILabel = {
		let label = UILabel(frame: .zero)
		label.text = "Москва"
		label.font = Constants.mainTextFont
		return label
	}()

	private lazy var downArrayImageView: UIImageView = {
		let imageView = UIImageView(image: Constants.downArrowImage)
		imageView.contentMode = .scaleAspectFit
		return imageView
	}()

	private var selectTownStackView: UIStackView!

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

	// MARK: - Inits

	override init(frame: CGRect) {
		super.init(frame: frame)
		setupView()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

// MARK: - Private methods

extension MenuHeaderView {
	private func setupView() {
		backgroundColor = Constants.mainBackgroundColor
		setupTownStackView()
		addSubview(selectTownStackView)
		addSubview(bannerCollecitonView)
		addSubview(categoriesCollectionView)
		setupConstraits()
	}

	private func setupConstraits() {
		selectTownStackView.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			selectTownStackView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.selectTownStackViewTopAnchorConstant),
			selectTownStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.selectTownStackViewLeadingAnchorConstant)
		])

		bannerCollecitonView.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			bannerCollecitonView.topAnchor.constraint(equalTo: selectTownStackView.bottomAnchor, constant: Constants.bannerCollecitonViewTopAnchorConstant),
			bannerCollecitonView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.bannerCollecitonViewLeadingAnchorConstant),
			bannerCollecitonView.heightAnchor.constraint(equalToConstant: Constants.bannerCollecitonViewHeight),
			bannerCollecitonView.widthAnchor.constraint(equalToConstant: bounds.size.width)
		])

		categoriesCollectionView.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			categoriesCollectionView.topAnchor.constraint(equalTo: bannerCollecitonView.bottomAnchor, constant: Constants.categoriesCollectionViewTopAnchorConstant),
			categoriesCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.categoriesCollectionViewLeadingAnchorConstant),
			categoriesCollectionView.heightAnchor.constraint(equalToConstant: Constants.categoriesCollectionViewHeight),
			categoriesCollectionView.widthAnchor.constraint(equalToConstant: bounds.size.width)
		])
	}

	private func setupTownStackView() {
		selectTownStackView = UIStackView(arrangedSubviews: [townLabel, downArrayImageView])
		selectTownStackView.axis = .horizontal
		selectTownStackView.spacing = Constants.selectedTownSpacing
	}
}
