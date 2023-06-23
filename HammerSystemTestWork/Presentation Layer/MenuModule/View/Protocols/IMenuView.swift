//
//  IMenuView.swift
//  HammerSystemTestWork
//
//  Created by Ivan Lyaskovets on 22.06.2023.
//

import Foundation


/// Протокол вью Menu модуля
protocol IMenuView: AnyObject {
	func reloadUI()
	func scrollTableViewTo(indexPath: IndexPath)
}
