//
//  LocaDataService.swift
//  HammerSystemTestWork
//
//  Created by Ivan Lyaskovets on 23.06.2023.
//

import Foundation

/// Класс сервиса, отвечающего за работу с локальными данными
final class LocalDataService: ILocalDataService {

	// MARK: - Private properties

	private var coreDataService: ICoreDataService!

	// MARK: - Init

	init(coreDataService: ICoreDataService) {
		self.coreDataService = coreDataService
	}

	// MARK: - Public methods

	/// Метод сервиса, который отвечает за выгрузку данных из локальногохранилища
	/// - Returns: Результат выгрузки LoadingLocalCategoriesResult
	public func fetchCategories() -> LoadingLocalCategoriesResult {
		.empty
	}

	/// Метод сервиса, который сохраняет категорию в локальное хранилище
	/// - Parameter category: Текущая категория
	public func saveCategory(category: CategoryModel, food: [FoodModel]) {

	}
}
