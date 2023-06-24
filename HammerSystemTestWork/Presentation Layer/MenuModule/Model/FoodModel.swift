//
//  FoodModel.swift
//  HammerSystemTestWork
//
//  Created by Ivan Lyaskovets on 22.06.2023.
//

import Foundation
import UIKit

/// Модель блюда
struct FoodModel {
	let id: UUID
	let title: String
	let decription: String
	var image: UIImage?
	let price: Int
}
