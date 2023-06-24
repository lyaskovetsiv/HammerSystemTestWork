//
//  SelectTownView.swift
//  HammerSystemTestWork
//
//  Created by Ivan Lyaskovets on 22.06.2023.
//

import UIKit


/// Класс вью с выбором года в Menu модуле
final class SelectTownView: UIView {

	// MARK: - Private constants

	private enum Constants {
		// Fonts
		static let mainTextFont: UIFont = .systemFont(ofSize: 17)
		// Colors
		static let mainBackgroundColor: UIColor = #colorLiteral(red: 0.9487603307, green: 0.9565995336, blue: 0.9732769132, alpha: 1)
		// Sizes
		static let selectedTownSpacing: CGFloat = 8
		static let selectTownStackViewHeight: CGFloat = 60
		// Images
		static let downArrowImage: UIImage? = UIImage(named: "downArrayIcon")
		// Constraits
		static let selectTownStackViewTopAnchorConstant: CGFloat = 16
		static let selectTownStackViewLeadingAnchorConstant: CGFloat = 16
		static let selectTownStackViewBottomAnchorConstant: CGFloat = 16
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

	// MARK: - Inits

	override init(frame: CGRect) {
		super.init(frame: frame)
		setupView()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

// MARK: - Private methods

extension SelectTownView {
	private func setupView() {
		backgroundColor = Constants.mainBackgroundColor
		setupTownStackView()
		addSubview(selectTownStackView)
		setupConstraits()
	}

	private func setupConstraits() {
		selectTownStackView.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			selectTownStackView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.selectTownStackViewTopAnchorConstant),
			selectTownStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.selectTownStackViewLeadingAnchorConstant),
			selectTownStackView.heightAnchor.constraint(equalToConstant: Constants.selectTownStackViewHeight),
			selectTownStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Constants.selectTownStackViewBottomAnchorConstant)
		])
	}

	private func setupTownStackView() {
		selectTownStackView = UIStackView(arrangedSubviews: [townLabel, downArrayImageView])
		selectTownStackView.axis = .horizontal
		selectTownStackView.spacing = Constants.selectedTownSpacing
	}
}
