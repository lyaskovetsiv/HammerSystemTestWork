//
//  LoadingLocalPromoResult.swift
//  HammerSystemTestWork
//
//  Created by Ivan Lyaskovets on 24.06.2023.
//

import Foundation


/// Перечисление с результатом загрузки категорий с акциями из локального хранилища
enum LoadingLocalPromoResult {
	case data([PromoModel])
	case empty
	case error
}
