//
//  LocaDataService.swift
//  HammerSystemTestWork
//
//  Created by Ivan Lyaskovets on 23.06.2023.
//

import Foundation
import UIKit

/// Класс сервиса, отвечающего за работу с локальными данными
final class LocalDataService: ILocalDataService {

	// MARK: - Private properties

	private var coreDataService: ICoreDataService!

	// MARK: - Init

	init(coreDataService: ICoreDataService) {
		self.coreDataService = coreDataService
	}

	// MARK: - Public methods

	/// Метод сервиса, который отвечает за выгрузку категорий из локальногохранилища
	/// - Returns: Результат выгрузки LoadingLocalCategoriesResult
	public func fetchCategories() -> LoadingLocalCategoriesResult {
		do {
			let dbCategories = try coreDataService.fetchCategories()
			let categories: [CategoryModel] = dbCategories.compactMap { dbCategory in
				// Проверяем поля
				guard let id = dbCategory.id, let title = dbCategory.title else {
					return nil
				}
				// Разворачиваем массив с блюдами
				var foods: [FoodModel] = []
				if let dbFoods = dbCategory.foods?.allObjects as? [DBFood] {
					for element in dbFoods {
						if let id = element.id, let title = element.title, let description = element.descr {
							var foodModel = FoodModel(id: id,
													  title: title,
													  decription: description,
													  image: nil,
													  price: Int(element.price))
							if let data = element.imageData {
								let image = UIImage(data: data)
								foodModel.image = image
							}
							foods.append(foodModel)
						}
					}
				}
				let sortedFoods = sortFoods(array: foods)
				// Возвращаем категорию
				return CategoryModel(id: id,
									 title: title,
									 foods: sortedFoods)
			}
			if categories.isEmpty {
				return .empty
			} else {
				return .data(categories)
			}
		} catch {
			print(error)
			return .error
		}
	}

	/// Метод сервиса, который сохраняет категорию в локальное хранилище
	/// - Parameter category: Текущая категория
	public func saveCategory(category: CategoryModel, foods: [FoodModel]) {
		coreDataService.saveCategory { context in
			// Проверяем есть ли такая категория уже в CoreData
			let fetchRequest = DBCategory.fetchRequest()
			fetchRequest.predicate = NSPredicate(format: "title == %@", category.title as CVarArg)
			if let _  = try context.fetch(fetchRequest).first {
				// Тут можно добавить проверку на наличие новых блюд
				print("CoreData: Такая категория уже есть")
			} else {
				print("CoreData: Создаём новую категорию")
				// Такой категории не существует, создаём новую категорию
				let newDBCategory = DBCategory(context: context)
				newDBCategory.id = category.id
				newDBCategory.title = category.title
				// Создаём новый массив с блюдами
				var newDBFoods: [DBFood] = []
				for food in foods {
					let newDBFood = DBFood(context: context)
					newDBFood.id = food.id
					newDBFood.title = food.title
					newDBFood.descr = food.decription
					newDBFood.imageData = food.image?.pngData()
					newDBFood.price = Float(food.price)
					newDBFood.category = newDBCategory
					newDBFoods.append(newDBFood)
				}
				newDBCategory.foods = NSSet(array: newDBFoods)
			}
		}
	}

	/// Метод сервиса, который отвечает за выгрузку акций из локальногохранилища
	/// - Returns: Результат выгрузки LoadingLocalCategoriesResult
	public func fetchPromo() -> LoadingLocalPromoResult {
		do {
			let dbPromo = try coreDataService.fetchPromo()
			let promo: [PromoModel] = dbPromo.compactMap { dbPromo in
				// Проверяем поля
				guard let id = dbPromo.id, let title = dbPromo.title else {
					return nil
				}
				var image: UIImage?
				if let data = dbPromo.imageData {
					image = UIImage(data: data)
				}
				// Возвращаем категорию
				return PromoModel(id: id,
								  title: title,
								  banner: image)
			}
			if promo.isEmpty {
				return .empty
			} else {
				return .data(promo)
			}
		} catch {
			print(error)
			return .error
		}
	}

	/// Метод сервиса, который сохраняет акцию в локальное хранилище
	/// - Parameter category: Текущая акция
	public func savePromo(promo: PromoModel) {
		coreDataService.saveCategory { context in
			// Проверяем есть ли такая акция уже в CoreData
			let fetchRequest = DBPromo.fetchRequest()
			fetchRequest.predicate = NSPredicate(format: "id == %@", promo.id as CVarArg)
			if let _  = try context.fetch(fetchRequest).first {
				print("CoreData: Такая акция уже есть")
			} else {
				print("CoreData: Создаём новую акцию")
				// Такой акции не существует, создаём новую акцию
				let newDBPromo = DBPromo(context: context)
				newDBPromo.id = promo.id
				newDBPromo.title = promo.title
				newDBPromo.imageData = promo.banner?.pngData()
			}
		}
	}
}

// MARK: - Private methods

extension LocalDataService {
	private func sortFoods(array: [FoodModel]) -> [FoodModel] {
		return array.sorted { food1, food2 in
			food1.id < food2.id
		}
	}

}
