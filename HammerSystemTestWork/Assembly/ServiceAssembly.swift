//
//  ServiceAssembly.swift
//  HammerSystemTestWork
//
//  Created by Ivan Lyaskovets on 23.06.2023.
//

import Foundation


/// Класс ассембле для сборки сервисных модулей
final class ServiceAssembly {
	public func getRemoteDataService() -> IRemoteDataService {
		return MockDataService()
	}
}
