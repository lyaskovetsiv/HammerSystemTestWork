//
//  ILocalDataService.swift
//  HammerSystemTestWork
//
//  Created by Ivan Lyaskovets on 23.06.2023.
//

import Foundation


/// Протокол сервиса, отвечающего за работу с локальными данными
protocol ILocalDataService: AnyObject {
	func fetchCategories() -> LoadingLocalCategoriesResult
	func saveCategory(category: CategoryModel, foods: [FoodModel])
	func fetchPromo() -> LoadingLocalPromoResult
	func savePromo(promo: PromoModel)
}

