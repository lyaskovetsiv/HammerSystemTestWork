//
//  IMenuPresenter.swift
//  HammerSystemTestWork
//
//  Created by Ivan Lyaskovets on 22.06.2023.
//

import Foundation

/// Протокол презентера Menu модуля
protocol IMenuPresenter: AnyObject {
	func getNumberOfFoodItems() -> Int
	func getNumberOfPromo() -> Int
	func getPromo(by indexPath: IndexPath) -> PromoModel
}
