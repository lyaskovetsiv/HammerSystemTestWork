//
//  FoodCell.swift
//  HammerSystemTestWork
//
//  Created by Ivan Lyaskovets on 22.06.2023.
//

import UIKit


/// Класс ячейки таблицы Menu модуля
final class FoodCell: UITableViewCell {

	// MARK: - Private constants

	private enum Constants {
		// Fonts
		static let mainFont: UIFont = .boldSystemFont(ofSize: 17)
		static let secondFont: UIFont = .systemFont(ofSize: 13)
		// Colors
		static let secondTextColor: UIColor = #colorLiteral(red: 0.6666294932, green: 0.6664453149, blue: 0.678909719, alpha: 1)
		static let btnColor: UIColor = #colorLiteral(red: 0.991042912, green: 0.2283459306, blue: 0.4105762243, alpha: 1)
		// Sizes
		static let foodImageViewWidth: CGFloat = 132
		static let foodImageViewHeight: CGFloat = 132
		static let btnBorderWidth: CGFloat = 1
		static let btnCornerRadius: CGFloat = 6
		static let buyBtnWidth: CGFloat = 87
		static let buyBtnHeight: CGFloat = 32
		// Constraits
		static let foodImageViewLeadingAnchorConstant: CGFloat = 16
		static let composeViewTrailingAnchorConstant: CGFloat = -24
		static let composeViewLeadingAnchorConstant: CGFloat = 32
		static let descriptionLabelTopAnchorConstant: CGFloat = 8
		static let buyBtnTopAnchorConstant: CGFloat = 16
	}

	// MARK: - UI

	private lazy var foodImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.contentMode = .scaleAspectFill
		imageView.clipsToBounds = true
		return imageView
	}()

	private lazy var activityIndicator: UIActivityIndicatorView = {
		let view = UIActivityIndicatorView(frame: .zero)
		view.isHidden = true
		return view
	}()

	private lazy var titleLabel: UILabel = {
		let label = UILabel()
		label.text = "Ветчина и грибы"
		label.font = Constants.mainFont
		label.numberOfLines = 1
		return label
	}()

	private lazy var descriptionLabel: UILabel = {
		let label = UILabel()
		label.font = Constants.secondFont
		label.textColor = Constants.secondTextColor
		label.text = "Ветчина, шампиньоны, увеличенная порция моцареллы, томатный соус"
		label.numberOfLines = 0
		return label
	} ()

	private lazy var buyBtn: UIButton = {
		let btn = UIButton(type: .system)
		btn.layer.cornerRadius = Constants.btnCornerRadius
		btn.layer.borderWidth = Constants.btnBorderWidth
		btn.layer.borderColor = Constants.btnColor.cgColor
		btn.tintColor = Constants.btnColor
		btn.setTitle("от 345 р", for: .normal)
		return btn
	}()

	private lazy var composeView: UIView = {
		let view = UIView()
		return view
	}()

	// MARK: - Inits

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupView()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

// MARK: - Private methods

extension FoodCell {
	private func setupView() {
		addSubview(foodImageView)
		addSubview(composeView)
		composeView.addSubview(titleLabel)
		composeView.addSubview(descriptionLabel)
		composeView.addSubview(buyBtn)
		foodImageView.addSubview(activityIndicator)
		setupConstraits()
	}

	private func setupConstraits() {
		foodImageView.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			foodImageView.widthAnchor.constraint(equalToConstant: Constants.foodImageViewWidth),
			foodImageView.heightAnchor.constraint(equalToConstant: Constants.foodImageViewHeight),
			foodImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
			foodImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.foodImageViewLeadingAnchorConstant)
		])

		composeView.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			composeView.centerYAnchor.constraint(equalTo: centerYAnchor),
			composeView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.composeViewTrailingAnchorConstant),
			composeView.leadingAnchor.constraint(equalTo: foodImageView.trailingAnchor, constant: Constants.composeViewLeadingAnchorConstant)
		])

		titleLabel.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			titleLabel.topAnchor.constraint(equalTo: composeView.topAnchor),
			titleLabel.leadingAnchor.constraint(equalTo: composeView.leadingAnchor),
			titleLabel.trailingAnchor.constraint(equalTo: composeView.trailingAnchor)
		])

		descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.descriptionLabelTopAnchorConstant),
			descriptionLabel.leadingAnchor.constraint(equalTo: composeView.leadingAnchor),
			descriptionLabel.trailingAnchor.constraint(equalTo: composeView.trailingAnchor)
		])

		buyBtn.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			buyBtn.widthAnchor.constraint(equalToConstant: Constants.buyBtnWidth),
			buyBtn.heightAnchor.constraint(equalToConstant: Constants.buyBtnHeight),
			buyBtn.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: Constants.buyBtnTopAnchorConstant),
			buyBtn.trailingAnchor.constraint(equalTo: composeView.trailingAnchor),
			buyBtn.bottomAnchor.constraint(equalTo: composeView.bottomAnchor),
		])

		activityIndicator.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			activityIndicator.centerXAnchor.constraint(equalTo: foodImageView.centerXAnchor),
			activityIndicator.centerYAnchor.constraint(equalTo: foodImageView.centerYAnchor)
		])
	}
}

// MARK: - IReusableCell

extension FoodCell: IReusableCell {
	static var identifier: String {
		return "foodCell"
	}
}

// MARK: - IConfurableCell

extension FoodCell: IConfurableCell {
	typealias ConfigurationModel = FoodModel
	/// Метод настройки ячейки
	/// - Parameter model: Модель типа PromoModel
	public func configure(with model: FoodModel) {
		// Clear cell
		titleLabel.text = ""
		descriptionLabel.text = ""
		foodImageView.image = nil
		buyBtn.setTitle("", for: .normal)
		// Configure cell
		titleLabel.text = model.title
		descriptionLabel.text = model.decription
		buyBtn.setTitle("от \(model.price) р", for: .normal)
		guard let image = model.image else {
			activityIndicator.isHidden = false
			activityIndicator.startAnimating()
			return
		}
		foodImageView.image = image
	}
}
