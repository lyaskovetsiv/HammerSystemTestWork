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
	private var remoteDataService: IRemoteDataService!
	private var localDataService: ILocalDataService!

	private var data: [CategoryModel] = []
	private var promo: [PromoModel] = []
	// ???
	private var food: [FoodModel] = FoodModel.getMockData()

	// MARK: - Inits

	init(view: IMenuView,
		 remoteDataService: IRemoteDataService,
		 localDataService: ILocalDataService) {
		self.view = view
		self.remoteDataService = remoteDataService
		self.localDataService = localDataService
		fetchMockData()
	}
}

extension MenuPresenter {
	private func fetchMockData() {
		remoteDataService.fetchCategories(completion: { [weak self] result in
			switch result {
			case .success(let categories):
				self?.data = categories
				DispatchQueue.main.async {
					self?.view.reloadUI()
				}
			case .failure(_):
				print("Some Error")
			}
		})

		remoteDataService.fetchPromos { [weak self] result in
			switch result {
			case .success(let promos):
				self?.promo = promos
				DispatchQueue.main.async {
					self?.view.reloadUI()
				}
			case .failure(_):
				print("Some Error")
			}
		}
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
		return data.count
	}

	/// Метод презентера, позволяющий получить конкретную категорию
	/// - Parameter indexPath: Индекс ячейки
	/// - Returns: Модель CategoryModel
	public func getCategory(by indexPath: IndexPath) -> CategoryModel {
		return data[indexPath.item]
	}

	/// Метод презентера, обрабатывающий нажатие по ячейке с категорией
	/// - Parameter indexPath: Индекс ячейки
	public func categoryDidTapped(by indexPath: IndexPath) {
		let model = data[indexPath.item]
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
