//
//  JobCell.swift
//  coople-test-task
//
//  Created by Eric Golovin on 14/08/2023.
//

import UIKit

protocol JobCellData {
    var assignmentName: String { get }
    var addressStreet: String { get }
    var locationZip: String { get }
    var city: String { get }
}

class JobCell: UITableViewCell {

    private struct Constants {
        let verticalInset = 8.0
        let middleVerticalInset = 4.0
        let horizontalInset = 16.0
    }

    // MARK: UI Components

    private let assignmentNameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .preferredFont(forTextStyle: .headline)
        label.numberOfLines = .zero
        return label
    }()

    private let addressStreetLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .preferredFont(forTextStyle: .headline)
        return label
    }()

    private let locationZipLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .preferredFont(forTextStyle: .body)
        return label
    }()

    private let cityLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .preferredFont(forTextStyle: .body)
        return label
    }()

    private lazy var locationZipCityStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            locationZipLabel,
            cityLabel
        ])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = constants.middleVerticalInset
        return stackView
    }()

    // MARK: Private properties

    private let constants = Constants()

    // MARK: Initialisers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Public methods

    func configure(with data: JobCellData) {
        assignmentNameLabel.text = data.assignmentName
        addressStreetLabel.text = data.addressStreet
        locationZipLabel.text = data.locationZip
        cityLabel.text = data.city
    }

    // MARK: Private methods

    private func setUpUI() {
        selectionStyle = .none
        contentView.backgroundColor = .systemGray5
        contentView.layer.borderColor = UIColor.systemBackground.cgColor
        contentView.layer.borderWidth = 2
        contentView.layer.cornerRadius = 10
        contentView.addSubview(assignmentNameLabel)
        contentView.addSubview(addressStreetLabel)
        contentView.addSubview(locationZipCityStackView)

        assignmentNameLabel.translatesAutoresizingMaskIntoConstraints = false
        addressStreetLabel.translatesAutoresizingMaskIntoConstraints = false
        locationZipCityStackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            // AssignmentNameLabel constraints
            assignmentNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: constants.verticalInset),
            assignmentNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: constants.horizontalInset),
            assignmentNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -constants.horizontalInset),

            // AddressStreetLabel constraints
            addressStreetLabel.topAnchor.constraint(equalTo: assignmentNameLabel.bottomAnchor, constant: constants.middleVerticalInset),
            addressStreetLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: constants.horizontalInset),
            addressStreetLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -constants.horizontalInset),

            // LocationZipCityStackView constraints
            locationZipCityStackView.topAnchor.constraint(equalTo: addressStreetLabel.bottomAnchor, constant: constants.middleVerticalInset),
            locationZipCityStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: constants.horizontalInset),
            locationZipCityStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -constants.horizontalInset),
            locationZipCityStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -constants.verticalInset)
        ])
    }
}
