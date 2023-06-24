//
//  LoadingLocalCategoriesResult.swift
//  HammerSystemTestWork
//
//  Created by Ivan Lyaskovets on 24.06.2023.
//

import Foundation


/// Перечисление с результатом загрузки категорий сблюдами из локального хранилища
enum LoadingLocalCategoriesResult {
	case data([CategoryModel])
	case empty
	case error
}
