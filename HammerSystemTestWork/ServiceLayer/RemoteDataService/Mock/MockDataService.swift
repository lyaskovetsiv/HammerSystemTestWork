//
//  MockDataService.swift
//  HammerSystemTestWork
//
//  Created by Ivan Lyaskovets on 23.06.2023.
//

import Foundation
import UIKit


/// Класс сервиса с удалёнными моковыми данными
final class MockDataService: IRemoteDataService {
	/// Метод сервиса, отвечающий за извлечение категорий блюд, посредством запроса в сеть
	/// - Parameter completion: Обработчик завершения
	public func fetchCategories(completion: @escaping(Result<[CategoryModel], Error>) -> Void) {
		completion(.success(getMockCategories()))
	}

	/// Метод сервиса, отвечающий за извлечение промоакций, посредством запроса в сеть
	/// - Parameter completion: Обработчик завершения
	public func fetchPromos(completion: @escaping(Result<[PromoModel], Error>) -> Void) {
		completion(.success(getMockPromos()))
	}
}

// MARK: - Private methods

extension MockDataService {
	private func getMockCategories() -> [CategoryModel] {
		let category1 = CategoryModel(id: "cat1", title: "Пицца",
									  foods: [
										FoodModel(id: "piz1",
												  title: "Ветчина и грибы",
												  decription: "Ветчина, шампиоьоны, увеличенная порция моцареллы, томатный соус",
												  image: UIImage(named: "pizza1"),
												  price: 345),
										FoodModel(id: "piz2",
												  title: "Баварские колбаски",
												  decription: "Баварские колбаски, ветчина, пикатная пепперони, острая чоризо, моцарелла, томатный соус",
												  image: UIImage(named: "pizza2"),
												  price: 345),
										FoodModel(id: "piz3",
												  title: "Нежный лосось",
												  decription: "Лосось, томаты черри, моцарелла, соус песто",
												  image: UIImage(named: "pizza3"),
												  price: 345),
										FoodModel(id: "piz4",
												  title: "Пицца четыре сыра",
												  decription: "Соус Карбонара, Сыр Моцарелла, Сыр Пармезан, и многое другое",
												  image: nil,
												  price: 345)
									  ])
		let category2 = CategoryModel(id: "cat2", title: "Комбо",
									  foods: [
										FoodModel(id: "combo1",
												  title: "Сет №1",
												  decription: "Описание сета",
												  image: UIImage(named: "combo1"),
												  price: 700),
										FoodModel(id: "combo2",
												  title: "Сет №2",
												  decription: "Описание сета",
												  image: UIImage(named: "combo2"),
												  price: 600),
										FoodModel(id: "combo3",
												  title: "Сет №3",
												  decription: "Описание сета",
												  image: UIImage(named: "combo3"),
												  price: 800),
										FoodModel(id: "combo4",
												  title: "Сет №4",
												  decription: "Описание сета",
												  image: (UIImage(named: "combo4")),
												  price: 900)
									  ])
		let category3 = CategoryModel(id: "cat3", title: "Десерты",
									  foods: [
										FoodModel(id: "tasty1",
												  title: "Чизкейк манго",
												  decription: "Описание чизкейка",
												  image: UIImage(named: "tasty1"),
												  price: 200),
										FoodModel(id: "tasty2",
												  title: "Фруктовый ролл",
												  decription: "Описание ролла",
												  image: UIImage(named: "tasty2"),
												  price: 345),
										FoodModel(id: "tasty3",
												  title: "Меренга с вишней",
												  decription: "Описание меренги",
												  image: UIImage(named: "tasty3"),
												  price: 345),
										FoodModel(id: "tasty4",
												  title: "Шоколадный торт",
												  decription: "Описание торта",
												  image: (UIImage(named: "tasty4")),
												  price: 345)
									  ])
		let category4 = CategoryModel(id: "cat4", title: "Напитки",
									  foods: [
										FoodModel(id: "drink1",
												  title: "Батлика 0, грейпфрукт ",
												  decription: "Безалкогольное пиво",
												  image: UIImage(named: "drink1"),
												  price: 100),
										FoodModel(id: "drink2",
												  title: "Лимонад Evervess",
												  decription: "Вкус Cola",
												  image: UIImage(named: "drink2"),
												  price: 100),
										FoodModel(id: "drink3",
												  title: "Сок J7",
												  decription: "Сок ананасовый, 1 литр",
												  image: UIImage(named: "drink3"),
												  price: 100),
										FoodModel(id: "drink4",
												  title: "Сок Я",
												  decription: "Сок томатный, 1 литр",
												  image: UIImage(named: "drink4"),
												  price: 100)
									  ])
		return [category1, category2, category3, category4]
	}

	private func getMockPromos() -> [PromoModel] {
		return [
			PromoModel(id: "pr1",
					   title: "2-ая пицца за 2 рубля",
					   banner: UIImage(named: "promo1")),
			PromoModel(id: "pr2",
					   title: "Скидка 30% на первый заказ",
					   banner: UIImage(named: "promo2"))
		]
	}
}
