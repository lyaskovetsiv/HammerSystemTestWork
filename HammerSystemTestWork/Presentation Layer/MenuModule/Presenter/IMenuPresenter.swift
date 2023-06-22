//
//  IMenuPresenter.swift
//  HammerSystemTestWork
//
//  Created by Ivan Lyaskovets on 22.06.2023.
//

import Foundation

/// Протокол презентера Menu модуля
protocol IMenuPresenter: AnyObject {
	func getNumberOfFoodItems() -> Int
	func getFood(by indexPath: IndexPath) -> FoodModel

	func getNumberOfPromo() -> Int
	func getPromo(by indexPath: IndexPath) -> PromoModel

	func getCategory(by indexPath: IndexPath) -> CategoryModel
	func getNumberOfCategories() -> Int
}
