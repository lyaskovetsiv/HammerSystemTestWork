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
		static let textBannerImage: UIImage? = nil
	}

	// MARK: - UI

	private lazy var bannerImageView: UIImageView = {
		let imageView = UIImageView(image: Constants.textBannerImage)
		imageView.contentMode = .scaleAspectFit
		imageView.backgroundColor = .gray
		imageView.layer.cornerRadius = 8
		return imageView
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
	}
}

// MARK: - IReusableCell

extension BannerCell: IReusableCell {
	static var identifier: String {
		return "bannerCell"
	}
}
