//
//  IConfurableCell.swift
//  HammerSystemTestWork
//
//  Created by Ivan Lyaskovets on 22.06.2023.
//

import Foundation

protocol IConfurableCell: AnyObject {
	associatedtype ConfigurationModel
	func configure(with model: ConfigurationModel)
}
