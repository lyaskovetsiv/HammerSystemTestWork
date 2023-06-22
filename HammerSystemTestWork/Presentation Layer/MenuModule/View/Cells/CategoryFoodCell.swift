//
//  CategoryFoodCell.swift
//  HammerSystemTestWork
//
//  Created by Ivan Lyaskovets on 22.06.2023.
//

import UIKit


/// Класс ячейки коллекции с категориями
final class CategoryFoodCell: UICollectionViewCell {

}

// MARK: - Private methods

extension CategoryFoodCell {
	private func setupView() {

	}
}

// MARK: - IReusableCell

extension CategoryFoodCell: IReusableCell {
	static var identifier: String {
		return "categoryFoodCell"
	}
}
