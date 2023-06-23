//
//  ServiceAssembly.swift
//  HammerSystemTestWork
//
//  Created by Ivan Lyaskovets on 23.06.2023.
//

import Foundation


/// Класс ассембле для сборки сервисных модулей
final class ServiceAssembly {
	/// Метод сервис ассембле, отвечающий за создание RemoteDataService
	/// - Returns: Экземпляр IRemoteDataService
	public func getRemoteDataService() -> IRemoteDataService {
		return MockDataService()
	}

	/// Метод сервис ассембле, отвечающий за создание LocalDataService
	/// - Returns: Экземпляр ILocalDataService
	public func getLocalDataService() -> ILocalDataService {
		return LocalDataService(coreDataService: CoreDataService())
	}
}
