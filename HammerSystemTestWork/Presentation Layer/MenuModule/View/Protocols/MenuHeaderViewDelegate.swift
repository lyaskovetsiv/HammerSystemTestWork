//
//  MenuHeaderViewDelegate.swift
//  HammerSystemTestWork
//
//  Created by Ivan Lyaskovets on 22.06.2023.
//

import Foundation
import UIKit

protocol MenuHeaderViewDelegate: AnyObject {
	func numberOfItems(in collectionView: UICollectionView) -> Int
	func cellForItem(at indexPath: IndexPath, collectionView: UICollectionView) -> UICollectionViewCell
}
