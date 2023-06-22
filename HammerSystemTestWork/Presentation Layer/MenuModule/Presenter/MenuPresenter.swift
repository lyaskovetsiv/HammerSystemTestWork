//
//  MenuPresenter.swift
//  HammerSystemTestWork
//
//  Created by Ivan Lyaskovets on 22.06.2023.
//

import Foundation


/// Класс презентера Menu  модуля
final class MenuPresenter {

	private weak var view: IMenuView!
	private var foodItems = 10
	private var promo: [PromoModel] = PromoModel.getMockData()

	// MARK: - Inits

	init(view: IMenuView) {
		self.view = view
	}
}

// MARK: - IMenuPresenter

extension MenuPresenter: IMenuPresenter {

	public func getNumberOfFoodItems() -> Int {
		return foodItems
	}

	func getNumberOfPromo() -> Int {
		return promo.count
	}
	
	func getPromo(by indexPath: IndexPath) -> PromoModel {
		return promo[indexPath.item]
	}
}

