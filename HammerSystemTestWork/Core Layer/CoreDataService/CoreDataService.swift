//
//  CoreDataService.swift
//  HammerSystemTestWork
//
//  Created by Ivan Lyaskovets on 23.06.2023.
//

import Foundation
import CoreData


/// Класс, отвечающий за работу с CoreData
final class CoreDataService: ICoreDataService {

	// MARK: - Private properties

	private lazy var persistentContainer: NSPersistentContainer = {
		let container = NSPersistentContainer(name: "Menu")
		container.loadPersistentStores {  _ , error in
			guard let error else { return }
			print(error)
		}
		return container
	}()

	private var viewContext: NSManagedObjectContext {
		persistentContainer.viewContext
	}

	// MARK: - Public methods

	/// Метод, возвращающий из CoreData массив c  DBCategories
	/// - Returns: Массив DBCategories
	public func fetchCategories() throws -> [DBCategory] {
		let fetchRequst = DBCategory.fetchRequest()
		let sortDescriptor = NSSortDescriptor(key: "id", ascending: true)
		fetchRequst.sortDescriptors = [sortDescriptor]
		return try viewContext.fetch(fetchRequst)
	}

	/// Метод, который сохраняет категорию в СoreData
	/// - Parameter block: Замыкание с контекстом, которое может выбросить ошибку
	public func saveCategory(block: @escaping (NSManagedObjectContext) throws -> Void) {
		let backgroundContext = persistentContainer.newBackgroundContext()
		backgroundContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
		backgroundContext.perform {
			do {
				try block(backgroundContext)
				if backgroundContext.hasChanges {
					try backgroundContext.save()
				}
			} catch {
				print(error)
			}
		}
	}

	/// Метод, возвращающий из CoreData массив c  DBPromo
	/// - Returns: Массив DBPromo
	public func fetchPromo() throws -> [DBPromo] {
		let fetchRequst = DBPromo.fetchRequest()
		let sortDescriptor = NSSortDescriptor(key: "id", ascending: true)
		fetchRequst.sortDescriptors = [sortDescriptor]
		return try viewContext.fetch(fetchRequst)
	}

	/// Метод, который сохраняет акцию  в СoreData
	/// - Parameter block: Замыкание с контекстом, которое может выбросить ошибку
	public func savePromo(block: @escaping (NSManagedObjectContext) throws -> Void) {
		let backgroundContext = persistentContainer.newBackgroundContext()
		backgroundContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
		backgroundContext.perform {
			do {
				try block(backgroundContext)
				if backgroundContext.hasChanges {
					try backgroundContext.save()
				}
			} catch {
				print(error)
			}
		}
	}
}
