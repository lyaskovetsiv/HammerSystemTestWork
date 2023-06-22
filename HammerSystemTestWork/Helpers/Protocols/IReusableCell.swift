//
//  IReusableCell.swift
//  HammerSystemTestWork
//
//  Created by Ivan Lyaskovets on 22.06.2023.
//

import Foundation

/// Прокотол для переиспользуемых ячеек
protocol IReusableCell: AnyObject {
	static var identifier: String { get }
}
