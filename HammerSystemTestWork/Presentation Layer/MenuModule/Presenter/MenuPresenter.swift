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

	private var promo: [PromoModel] = []
	private var data: [CategoryModel] = []
	private var test: [[FoodModel]] = []

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
				// Assignment
				self?.data = categories
				for category in categories {
					self?.test.append(category.foods)
				}
				// Reload UI
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
		let array = test.flatMap { $0 }
		return array.count
	}

	/// Метод презентера, позволяющий получить конкретное блюдл
	/// - Parameter indexPath: Индекс ячейки
	/// - Returns:Модель FoodModel
	public func getFood(by indexPath: IndexPath) -> FoodModel {
		let array = test.flatMap { $0 }
		return array[indexPath.row]
	}

	/// Метод презентера, обрабатывающий нажатие по ячейке с блюдом
	/// - Parameter indexPath: Индекс ячейки
	public func foodDidTapped(by indexPath: IndexPath) {
		let array = test.flatMap { $0 }
		print("Выбран товар: \(array[indexPath.row].title)")
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
		// 1. Получили индекс категории из вью
		// 2. Найти блюдо в категории по индексу
		guard let firstElementOfCategory = test[indexPath.item].first else {
			print("Данной категории не существует")
			return
		}
		// 3. Найти индекс блюда в таблице
		let index = test.flatMap { $0 }
			.firstIndex { $0.id == firstElementOfCategory.id
			}
		// 4. Просколить таблицу
		if let index = index {
			let indexPath = IndexPath(row: index, section: 0)
			view.scrollTableViewTo(indexPath: indexPath)
		}
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
