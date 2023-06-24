//
//  CategoryModel.swift
//  HammerSystemTestWork
//
//  Created by Ivan Lyaskovets on 22.06.2023.
//

import Foundation


/// Модель категории блюд
struct CategoryModel {
	let id: String
	let title: String
	let foods: [FoodModel]
}
