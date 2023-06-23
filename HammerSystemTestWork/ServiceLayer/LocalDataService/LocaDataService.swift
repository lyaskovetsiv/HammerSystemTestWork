//
//  LocaDataService.swift
//  HammerSystemTestWork
//
//  Created by Ivan Lyaskovets on 23.06.2023.
//

import Foundation

/// Класс сервиса, отвечающего за работу с локальными данными
final class LocalDataService: ILocalDataService {

	private var coreDataService: ICoreDataService!

	// MARK: - Init

	init(coreDataService: ICoreDataService) {
		self.coreDataService = coreDataService
	}
}
