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
	private var categories: [CategoryModel] = []
	private var foods: [[FoodModel]] = []

	// MARK: - Inits

	init(view: IMenuView,
		 remoteDataService: IRemoteDataService,
		 localDataService: ILocalDataService) {
		self.view = view
		self.remoteDataService = remoteDataService
		self.localDataService = localDataService
		loadCategories()
		loadPromos()
	}
}

extension MenuPresenter {
	private func loadCategories() {
		let resultCategories = loadCategoriesFromLocalStorage()
		switch resultCategories {
		case .data(let savedCategories):
			print("SystemLog: Загружаем данные с категориями из CoreData")
			self.categories = savedCategories
			for category in savedCategories {
				foods.append(category.foods)
			}
			view.reloadUI(type: .category)
			// loadCategoriesFromServer()
		case .empty, .error:
			// Тут можно обработать ошибки и кейс с пустыми данными
			print("SystemLog: Загружаем данные с категориями из сети")
			loadCategoriesFromServer()
		}
	}

	private func loadPromos() {
		let resultPromos = loadPromosFromLocalStorage()
		switch resultPromos {
		case .data(let promo):
			print("SystemLog: Загружаем данные с акциями из CoreData")
			self.promo = promo
			view.reloadUI(type: .category)
			// loadPromoFromServer()
		case .empty, .error:
			// Тут можно обработать ошибки и кейс с пустыми данными
			print("SystemLog: Загружаем данные с категориями из сети")
			loadPromoFromServer()
		}
	}

	// Server
	private func loadCategoriesFromServer() {
		DispatchQueue.global(qos: .background).async {
			// Скачиваем данные из сети
			self.remoteDataService.fetchCategories(completion: { [weak self] result in
				switch result {
				case .success(let categories):
					self?.categories = categories
					// Сохраняем данные CoreData
					for category in categories {
						self?.foods.append(category.foods)
						self?.localDataService.saveCategory(category: category, foods: category.foods)
					}
					// Обновляем интерфейс с новыми данными
					DispatchQueue.main.async {
						self?.view.reloadUI(type: .category)
					}
				case .failure(_):
					// Тут может быть обратока кейса с ошибкой
					print("Some Error")
				}
			})
		}
	}

	private func loadPromoFromServer() {
		DispatchQueue.global(qos: .background).async {
			self.remoteDataService.fetchPromos { [weak self] result in
				switch result {
				case .success(let promos):
					self?.promo = promos
					// Сохраняем данные CoreData
					for promo in promos {
						self?.localDataService.savePromo(promo: promo)
					}
					// Обновляем интерфейс с новыми данными
					DispatchQueue.main.async {
						self?.view.reloadUI(type: .promo)
					}
				case .failure(_):
					// Нет соединения или ошибка с сервера
					print("Some Error")
				}
			}
		}
	}

	// LocalStorage
	private func loadCategoriesFromLocalStorage() -> LoadingLocalCategoriesResult {
		localDataService.fetchCategories()
	}

	private func saveCategoryOnLocalStorage(category: CategoryModel) {
		localDataService.saveCategory(category: category, foods: category.foods)
	}

	private func loadPromosFromLocalStorage() -> LoadingLocalPromoResult {
		localDataService.fetchPromo()
	}

	private func savePromoOnLocalStorage(promo: PromoModel) {
		localDataService.savePromo(promo: promo)
	}
}

// MARK: - IMenuPresenter

extension MenuPresenter: IMenuPresenter {
	// FOODS
	/// Метод презентера, возвращающий количество блюд
	/// - Returns: Количество блюд
	public func getNumberOfFoodItems() -> Int {
		let array = foods.flatMap { $0 }
		return array.count
	}

	/// Метод презентера, позволяющий получить конкретное блюдл
	/// - Parameter indexPath: Индекс ячейки
	/// - Returns:Модель FoodModel
	public func getFood(by indexPath: IndexPath) -> FoodModel {
		let array = foods.flatMap { $0 }
		return array[indexPath.row]
	}

	/// Метод презентера, обрабатывающий нажатие по ячейке с блюдом
	/// - Parameter indexPath: Индекс ячейки
	public func foodDidTapped(by indexPath: IndexPath) {
		let array = foods.flatMap { $0 }
		print("Выбран товар: \(array[indexPath.row].title)")
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
		// 1. Получили индекс категории из вью
		// 2. Найти блюдо в категории по индексу
		guard let firstElementOfCategory = foods[indexPath.item].first else {
			print("Данной категории не существует")
			return
		}
		// 3. Найти индекс блюда в таблице
		let index = foods.flatMap { $0 }
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

	/// Метод презентера, отслеживающий скролл таблицы
	/// - Parameter indexPath: Индекс первой видимой ячейки
	public func tableViewDidScroll(indexPath: IndexPath) {
		// Найти элемент во flat array блюд
		let array = foods.flatMap { $0 }
		let food = array[indexPath.row]
		// Найти элемент в списке с категориями и вернуть индекс категории
		let indexCategory = foods.firstIndex { category in
			category.contains { subFood in
				subFood.id == food.id
			}
		}
		if let indexCategory = indexCategory {
			// Вызвать у view метод по установке выделения
			let indexPath = IndexPath(item: indexCategory, section: 0)
			view.selectCellFromCollectionView(indexPath: indexPath)
		}
	}

	/// Метод перезентера, обрабатывающий метож ЖЦ VC viewDidAppear
	public func viewDidAppear() {
		let indexPath = IndexPath(item: 0, section: 0)
		view.selectCellFromCollectionView(indexPath: indexPath)
	}
}
