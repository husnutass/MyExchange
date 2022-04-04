//
//  MainTableViewCell.swift
//  MyExchange
//
//  Created by Hüsnü Taş on 18.01.2022.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    
    static let identifier = "mainCell"
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var mainStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [nameLabel, rateLabel])
        view.axis = .horizontal
        view.alignment = .fill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var rateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addComponents()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func addComponents() {
        addSubview(contentView)
        contentView.addSubview(containerView)
        containerView.addSubview(mainStackView)
    }
    
    private func configureView() {
        containerView.expandView(to: contentView, with: 20)
        mainStackView.expandView(to: containerView)
    }
    
    private func roundDouble(number: Double) -> Double {
        return (number * 10000).rounded() / 10000
    }
    
    func setData(cellData: Rate?) {
        guard let cellData = cellData else { return }
        nameLabel.text = cellData.assetIDQuote
        rateLabel.text = String(roundDouble(number: cellData.rate))
    }
    

}
