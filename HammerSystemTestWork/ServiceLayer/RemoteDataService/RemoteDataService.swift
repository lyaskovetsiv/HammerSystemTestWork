//
//  RemoteDataService.swift
//  HammerSystemTestWork
//
//  Created by Ivan Lyaskovets on 23.06.2023.
//

import Foundation


/// Класс сервиса, отвечающего за работу с удалёнными данными
final class RemoteDataService: IRemoteDataService {

	private var networkService: INetworkService!

	// MARK: - Init

	init(networkService: INetworkService) {
		self.networkService = networkService
	}

	// MARK: - Public methods

	/// Метод сервиса, отвечающий за извлечение результат запроса в сеть
	/// - Parameter completion: Обработчик завершения
	public func fetchCategories(completion: @escaping (Result<[CategoryModel], Error>) -> Void) {

	}

	/// Метод сервиса, отвечающий за извлечение промоакций, посредством запроса в сеть
	/// - Parameter completion: Обработчик завершения
	public func fetchPromos(completion: @escaping(Result<[PromoModel], Error>) -> Void) {
		
	}
}


