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
	// FOODS
	/// Метод презентера, возвращающий количество блюд
	/// - Returns: Количество блюд
	public func getNumberOfFoodItems() -> Int {
		return food.count
	}

	/// Метод презентера, позволяющий получить конкретное блюдл
	/// - Parameter indexPath: Индекс ячейки
	/// - Returns:Модель FoodModel
	public func getFood(by indexPath: IndexPath) -> FoodModel {
		return food[indexPath.row]
	}

	/// Метод презентера, обрабатывающий нажатие по ячейке с блюдом
	/// - Parameter indexPath: Индекс ячейки
	public func foodDidTapped(by indexPath: IndexPath) {
		let model = food[indexPath.row]
		print("В корзину добавлен товар: \(model.title)")
	}

	// CATEGORIES
	/// Метод презентера, возвращающий количество категорий с блюдами
	/// - Returns: Количество категорий
	public func getNumberOfCategories() -> Int {
		return categories.count
	}

	/// Метод презентера, позволяющий получить конкретную категорию
	/// - Parameter indexPath: Индекс ячейки
	/// - Returns: Модель CategoryModel
	public func getCategory(by indexPath: IndexPath) -> CategoryModel {
		return categories[indexPath.item]
	}

	/// Метод презентера, обрабатывающий нажатие по ячейке с категорией
	/// - Parameter indexPath: Индекс ячейки
	public func categoryDidTapped(by indexPath: IndexPath) {
		let model = categories[indexPath.item]
		print("Выбрана категория: \(model.title)")
	}

	// PROMO
	/// Метод презентера, возвращающий количество рекламных акций
	/// - Returns: Количество рекламных баннеров
	public func getNumberOfPromo() -> Int {
		return promo.count
	}

	/// Метод презентера, позволяющий получить конкретную рекламную акцию
	/// - Parameter indexPath: Индекс ячейки
	/// - Returns: Модель PromoModel
	public func getPromo(by indexPath: IndexPath) -> PromoModel {
		return promo[indexPath.item]
	}

	/// Метод презентера, обрабатывающий нажатие по ячейке с баннером
	/// - Parameter indexPath: Индекс ячейки
	public func bannerDidTapped(by indexPath: IndexPath) {
		let model = promo[indexPath.item]
		print("Выбрана акция: \(model.title)")
	}
}
