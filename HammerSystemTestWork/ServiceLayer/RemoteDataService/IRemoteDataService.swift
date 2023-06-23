//
//  IRemoteDataService.swift
//  HammerSystemTestWork
//
//  Created by Ivan Lyaskovets on 23.06.2023.
//

import Foundation


/// Протокол сервиса, отвечающего за работу с удалёнными данными
protocol IRemoteDataService: AnyObject {
	func fetchCategories(completion: @escaping(Result<[CategoryModel], Error>) -> Void)
	func fetchPromos(completion: @escaping(Result<[PromoModel], Error>) -> Void)
}
