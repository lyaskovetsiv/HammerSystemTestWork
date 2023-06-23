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
	func foodDidTapped(by indexPath: IndexPath)
	func getCategory(by indexPath: IndexPath) -> CategoryModel
	func getNumberOfCategories() -> Int
	func categoryDidTapped(by indexPath: IndexPath)
	func getNumberOfPromo() -> Int
	func getPromo(by indexPath: IndexPath) -> PromoModel
	func bannerDidTapped(by indexPath: IndexPath)
	func tableViewDidScroll(indexPath: IndexPath)
	func viewDidAppear()
}
