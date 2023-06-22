//
//  MainVC.swift
//  HammerSystemTestWork
//
//  Created by Ivan Lyaskovets on 22.06.2023.
//

import UIKit


/// Главный TabBarController приложения
final class MainVC: UITabBarController {

	// MARK: - Private  constants
	private enum Constants {
		// Images
		static let menuImage: UIImage? = UIImage(named: "menuIcon")
		static let contactsImage: UIImage? = UIImage(named: "contactsIcon")
		static let profileImage: UIImage? = UIImage(named: "profileIcon")
		static let trashImage: UIImage? = UIImage(named: "trashIcon")
		// Colors
		static let selectedVCColor: UIColor = #colorLiteral(red: 0.991042912, green: 0.2283459306, blue: 0.4105762243, alpha: 1)
	}


	// MARK: - LifeCycleOfVC

	override func viewDidLoad() {
		super.viewDidLoad()
		setupView()
	}
}

// MARK: - Private methods

extension MainVC {
	private func setupView() {
		tabBar.tintColor = Constants.selectedVCColor
		setupControllers()
	}

	private func setupControllers() {
		let menuVC = MenuViewController()
		setupVC(vc: menuVC, image: Constants.menuImage, title: "Меню")

		// Моковые вьюконтроллеры
		let contactsVC = UIViewController()
		setupVC(vc: contactsVC, image: Constants.contactsImage, title: "Контакты")

		let profileVC = UIViewController()
		setupVC(vc: profileVC, image: Constants.profileImage, title: "Профиль")

		let trashVC = UIViewController()
		setupVC(vc: trashVC, image: Constants.trashImage, title: "Корзина")

		self.viewControllers = [menuVC, contactsVC, profileVC, trashVC]
	}

	private func setupVC(vc: UIViewController, image: UIImage?, title: String) {
		vc.tabBarItem.image = image
		vc.tabBarItem.title = title
	}
}
