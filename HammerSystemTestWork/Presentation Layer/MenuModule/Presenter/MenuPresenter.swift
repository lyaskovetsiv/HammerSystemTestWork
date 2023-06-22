//
//  MenuPresenter.swift
//  HammerSystemTestWork
//
//  Created by Ivan Lyaskovets on 22.06.2023.
//

import Foundation


/// Класс презентера Menu  модуля
final class MenuPresenter {

	// MARK: - Private properties

	private weak var view: IMenuView!
	private var food: [FoodModel] = FoodModel.getMockData()
	private var categories: [CategoryModel] = CategoryModel.getMockData()
	private var promo: [PromoModel] = PromoModel.getMockData()

	// MARK: - Inits

	init(view: IMenuView) {
		self.view = view
	}
}

// MARK: - IMenuPresenter

extension MenuPresenter: IMenuPresenter {

	public func getNumberOfFoodItems() -> Int {
		return food.count
	}

	public func getFood(by indexPath: IndexPath) -> FoodModel {
		return food[indexPath.row]
	}

	public func getNumberOfCategories() -> Int {
		return categories.count
	}

	public func getCategory(by indexPath: IndexPath) -> CategoryModel {
		return categories[indexPath.item]
	}

	public func getNumberOfPromo() -> Int {
		return promo.count
	}
	
	public func getPromo(by indexPath: IndexPath) -> PromoModel {
		return promo[indexPath.item]
	}

	public func categoryDidTapped(by indexPath: IndexPath) {
		let model = categories[indexPath.item]
			print("Выбрана категория: \(model.title)")
	}

	public func bannerDidTapped(by indexPath: IndexPath) {
		let model = promo[indexPath.item]
		print("Выбрана акция: \(model.title)")
	}
}
