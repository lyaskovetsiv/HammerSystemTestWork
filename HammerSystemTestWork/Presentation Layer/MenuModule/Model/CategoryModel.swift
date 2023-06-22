//
//  CategoryModel.swift
//  HammerSystemTestWork
//
//  Created by Ivan Lyaskovets on 22.06.2023.
//

import Foundation


/// Модель категории блюд
struct CategoryModel {
	let id: UUID
	let title: String
}

extension CategoryModel {
	static func getMockData() -> [CategoryModel] {
		return [
			CategoryModel(id: UUID(), title: "Пицца"),
			CategoryModel(id: UUID(), title: "Комбо"),
			CategoryModel(id: UUID(), title: "Десерты"),
			CategoryModel(id: UUID(), title: "Напитки"),
		]
	}
}
