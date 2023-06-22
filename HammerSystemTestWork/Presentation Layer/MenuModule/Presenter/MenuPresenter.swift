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

	// MARK: - Inits

	init(view: IMenuView) {
		self.view = view
	}
}

// MARK: - IMenuPresenter

extension MenuPresenter: IMenuPresenter {

}

