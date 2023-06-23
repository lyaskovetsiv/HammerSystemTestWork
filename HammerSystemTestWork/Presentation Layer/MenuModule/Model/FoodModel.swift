//
//  FoodModel.swift
//  HammerSystemTestWork
//
//  Created by Ivan Lyaskovets on 22.06.2023.
//

import Foundation
import UIKit


/// Модель блюда
struct FoodModel {
	let id: UUID
	let title: String
	let decription: String
	let image: UIImage?
	let price: Int
}

extension FoodModel {
	static func getMockData() -> [FoodModel] {
		return [
			FoodModel(id: UUID(),
					  title: "Ветчина и грибы",
					  decription: "Ветчина, шампиоьоны, увеличенная порция моцареллы, томатный соус",
					  image: UIImage(named: "pizza1"),
					  price: 345)
			,
			FoodModel(id: UUID(),
					  title: "Баварские колбаски",
					  decription: "Баварские колбаски, ветчина, пикатная пепперони, острая чоризо, моцарелла, томатный соус",
					  image: UIImage(named: "pizza2"),
					  price: 345),
			FoodModel(id: UUID(),
					  title: "Нежный лосось",
					  decription: "Лосось, томаты черри, моцарелла, соус песто",
					  image: UIImage(named: "pizza3"),
					  price: 345),
			FoodModel(id: UUID(),
					  title: "Пицца четыре сыра",
					  decription: "Соус Карбонара, Сыр Моцарелла, Сыр Пармезан, и многое другое",
					  image: nil,
					  price: 345)
		]
	}
}
