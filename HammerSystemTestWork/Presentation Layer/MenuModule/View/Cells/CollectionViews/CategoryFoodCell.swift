//
//  CategoryFoodCell.swift
//  HammerSystemTestWork
//
//  Created by Ivan Lyaskovets on 22.06.2023.
//

import UIKit


/// Класс ячейки коллекции с категориями
final class CategoryFoodCell: UICollectionViewCell {

	private enum Constants {
		// Fonts
		static let mainFont: UIFont = .systemFont(ofSize: 13)
		// Colors
		static let mainColor: UIColor = #colorLiteral(red: 0.991042912, green: 0.2283459306, blue: 0.4105762243, alpha: 1)
		static let cellBorderWidth: CGFloat = 1
		// Sizes
		static let cellCornerRadius: CGFloat = 16

	}

	// MARK: - UI

	private lazy var titleLabel: UILabel = {
		let label = UILabel(frame: .zero)
		label.text = "Категория"
		label.textColor = Constants.mainColor
		label.font = Constants.mainFont
		return label
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

extension CategoryFoodCell {
	private func setupView() {
		backgroundColor = .clear
		layer.cornerRadius = Constants.cellCornerRadius
		layer.borderWidth = Constants.cellBorderWidth
		layer.borderColor = Constants.mainColor.cgColor
		addSubview(titleLabel)
		setupConstraits()
	}

	private func setupConstraits() {
		titleLabel.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
			titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
		])
	}
}

// MARK: - IReusableCell

extension CategoryFoodCell: IReusableCell {
	static var identifier: String {
		return "categoryFoodCell"
	}
}

// MARK: - IConfurableCell

extension CategoryFoodCell: IConfurableCell {
	typealias ConfigurationModel = CategoryModel
	/// Метод настройки ячейки
	/// - Parameter model: Модель типа CategoryModel
	public func configure(with model: CategoryModel) {
		// Clear cell
		titleLabel.text = ""
		// Configure cell
		titleLabel.text = model.title
	}
}
