//
//  ModuleAssembly.swift
//  HammerSystemTestWork
//
//  Created by Ivan Lyaskovets on 22.06.2023.
//

import Foundation
import UIKit


/// Класс ассембле для сборки модулей презентационного слоя
final class ModuleAssembly {

	static private var serviceAssembly: ServiceAssembly {
		return ServiceAssembly()
	}

	/// Метод ассембле для сборки Menu модуля
	/// - Returns: Экземпляр MenuViewController
	static func createMenuModule() -> MenuViewController {
		let view = MenuViewController()
		let presenter: IMenuPresenter = MenuPresenter(view: view,
													  remoteDataService: serviceAssembly.getRemoteDataService(),
													  localDataService: serviceAssembly.getLocalDataService())
		view.presenter = presenter
		return view
	}
}
