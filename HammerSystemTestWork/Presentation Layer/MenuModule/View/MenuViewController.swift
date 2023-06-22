//
//  MenuViewController.swift
//  HammerSystemTestWork
//
//  Created by Ivan Lyaskovets on 22.06.2023.
//

import UIKit


/// Класс вью Menu  модуля
class MenuViewController: UIViewController {

	// MARK: - Private constants

	private enum Constants {
		// Colors
		static let mainBackgroundColor: UIColor = #colorLiteral(red: 0.9487603307, green: 0.9565995336, blue: 0.9732769132, alpha: 1)
		// Fonts
		static let mainTextFont: UIFont = .systemFont(ofSize: 17)
		// Images
		static let downArrowImage: UIImage? = UIImage(named: "downArrayIcon")
		// Sizes
		static let selectedTownSpacing: CGFloat = 8
		// Constraits
		static let foodTableViewTopAnchor: CGFloat = 252
		static let selectTownStackViewTopAnchor: CGFloat = 16
		static let selectTownStackViewLeadingAnchor: CGFloat = 16
	}

	// MARK: - UI

	private lazy var townLabel: UILabel = {
		let label = UILabel(frame: .zero)
		label.text = "Москва"
		label.font = Constants.mainTextFont
		return label
	}()

	private lazy var downArrayImageView: UIImageView = {
		let imageView = UIImageView(image: Constants.downArrowImage)
		imageView.contentMode = .scaleAspectFit
		return imageView
	}()

	private var selectTownStackView: UIStackView!

	private lazy var foodTableView: UITableView = {
		let tableView = UITableView(frame: .zero)
		tableView.backgroundColor = .white
		tableView.layer.cornerRadius = 16
		return tableView
	}()

	// MARK: - LifeCycleOfVC

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		setupView()
	}
}


// MARK: - Private methods

extension MenuViewController {
	private func setupView() {
		view.backgroundColor = Constants.mainBackgroundColor
		setupTownStackView()

		view.addSubview(selectTownStackView)
		view.addSubview(foodTableView)
		setupConstraits()
	}

	private func setupConstraits() {
		selectTownStackView.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			selectTownStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.selectTownStackViewTopAnchor),
			selectTownStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.selectTownStackViewLeadingAnchor)
		])

		foodTableView.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			foodTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			foodTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			foodTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
			foodTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.foodTableViewTopAnchor)
		])
	}

	private func setupTownStackView() {
		selectTownStackView = UIStackView(arrangedSubviews: [townLabel, downArrayImageView])
		selectTownStackView.axis = .horizontal
		selectTownStackView.spacing = Constants.selectedTownSpacing
	}
}
