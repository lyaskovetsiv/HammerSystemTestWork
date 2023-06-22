//
//  BannerCell.swift
//  HammerSystemTestWork
//
//  Created by Ivan Lyaskovets on 22.06.2023.
//

import UIKit


/// Класс ячейки коллекции с баннерами
final class BannerCell: UICollectionViewCell {

	// MARK: - Private constants

	private enum Constants {
		// Images 
		static let textBannerImage: UIImage? = nil
	}

	// MARK: - UI

	private lazy var bannerImageView: UIImageView = {
		let imageView = UIImageView(image: Constants.textBannerImage)
		imageView.contentMode = .scaleAspectFill
		imageView.clipsToBounds = true
		imageView.backgroundColor = .gray
		return imageView
	}()

	private lazy var activityIndicator: UIActivityIndicatorView = {
		let view = UIActivityIndicatorView(frame: .zero)
		view.isHidden = true
		return view
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

extension BannerCell {
	private func setupView() {
		addSubview(bannerImageView)
		bannerImageView.addSubview(activityIndicator)
		setupConstraits()
	}

	private func setupConstraits() {
		bannerImageView.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			bannerImageView.topAnchor.constraint(equalTo: topAnchor),
			bannerImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
			bannerImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
			bannerImageView.trailingAnchor.constraint(equalTo: trailingAnchor)
		])

		activityIndicator.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			activityIndicator.centerXAnchor.constraint(equalTo: bannerImageView.centerXAnchor),
			activityIndicator.centerYAnchor.constraint(equalTo: bannerImageView.centerYAnchor),
		])
	}
}

// MARK: - IReusableCell

extension BannerCell: IReusableCell {
	static var identifier: String {
		return "bannerCell"
	}
}

// MARK: - IConfurableCell

extension BannerCell: IConfurableCell {
	typealias ConfigurationModel = PromoModel
	/// Метод настройки ячейки
	/// - Parameter model: Модель типа PromoModel
	public func configure(with model: PromoModel) {
		// Clear cell
		bannerImageView.image = nil
		// Configure cell
		guard let image = model.banner else {
			activityIndicator.isHidden = false
			activityIndicator.startAnimating()
			return
		}
		bannerImageView.image = image
	}
}
