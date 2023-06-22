//
//  BannerCell.swift
//  HammerSystemTestWork
//
//  Created by Ivan Lyaskovets on 22.06.2023.
//

import UIKit


/// Класс ячейки коллекции с баннерами
final class BannerCell: UICollectionViewCell {

}

// MARK: - Private methods

extension BannerCell {
	private func setupView() {

	}
}

// MARK: - IReusableCell

extension BannerCell: IReusableCell {
	static var identifier: String {
		return "bannerCell"
	}
}
