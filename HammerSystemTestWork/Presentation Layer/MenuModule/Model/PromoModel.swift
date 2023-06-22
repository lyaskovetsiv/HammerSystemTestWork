//
//  PromoModel.swift
//  HammerSystemTestWork
//
//  Created by Ivan Lyaskovets on 22.06.2023.
//

import Foundation
import UIKit


/// Модель рекламной кампании
struct PromoModel {
	let id: UUID
	let title: String
	let banner: UIImage?
}

extension PromoModel {
	static func getMockData() -> [PromoModel] {
		return [
			PromoModel(id: UUID(),
					   title: "2-ая пицца за 2 рубля",
					   banner: UIImage(named: "promo1")),
			PromoModel(id: UUID(),
					   title: "Скидка 30% на первый заказ",
					   banner: UIImage(named: "promo2"))
		]
	}
}
