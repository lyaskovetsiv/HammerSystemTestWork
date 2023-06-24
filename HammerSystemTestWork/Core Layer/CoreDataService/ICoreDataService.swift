//
//  ICoreDataService.swift
//  HammerSystemTestWork
//
//  Created by Ivan Lyaskovets on 23.06.2023.
//

import Foundation
import CoreData


/// Протокол сервиса, отвечающий за работу с CoreData
protocol ICoreDataService: AnyObject {
	func fetchCategories() throws -> [DBCategory]
	func saveCategory(block: @escaping (NSManagedObjectContext) throws -> Void)
	func fetchPromo() throws -> [DBPromo]
	func savePromo(block: @escaping (NSManagedObjectContext) throws -> Void)
}
