//
//  PromoModel.swift
//  HammerSystemTestWork
//
//  Created by Ivan Lyaskovets on 22.06.2023.
//

import Foundation
import UIKit

struct PromoModel {
	let id: UUID
	let banner: UIImage?
}

extension PromoModel {
	static func getMockData() -> [PromoModel] {
		return [
			PromoModel(id: UUID(), banner: UIImage(named: "promo1")),
			PromoModel(id: UUID(), banner: UIImage(named: "promo2"))
		]
	}
}
