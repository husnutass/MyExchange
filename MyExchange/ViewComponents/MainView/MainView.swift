//
//  MainView.swift
//  MyExchange
//
//  Created by Hüsnü Taş on 4.04.2022.
//

import UIKit

class MainView: UIView {
    
    weak var delegate: MainViewController?
    
    private var mainTableView = UITableView()

    private lazy var mainStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [basePickerView, activityIndicatorView, mainTableView])
        view.axis = .vertical
        view.alignment = .fill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var basePickerView: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.delegate = self
        picker.dataSource = self
        picker.userActivity?.title = "Base"
        picker.backgroundColor = .systemBackground
        return picker
    }()
    
    private lazy var activityIndicatorView: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addComponents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Configurations
    private func addComponents() {
        addSubview(mainStackView)
        configureView()
    }
    
    private func configureView() {
        configureTableView()
        mainStackView.expandView(to: self)
        activityIndicatorView.centerXAnchor.constraint(equalTo: mainStackView.centerXAnchor).isActive = true
    }
    
    private func configureTableView() {
        mainTableView.translatesAutoresizingMaskIntoConstraints = false
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.identifier)
    }
    
    func startAnimating() {
        activityIndicatorView.startAnimating()
    }
    
    func stopAnimating() {
        activityIndicatorView.stopAnimating()
    }

}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension MainView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return delegate?.exchangeRates.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.identifier) as? MainTableViewCell else { return UITableViewCell() }
        cell.setData(cellData: delegate?.exchangeRates[indexPath.row])
        return cell
    }
}

// MARK: - UIPickerViewDelegate, UIPickerViewDataSource
extension MainView: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        BaseAsset.allCases.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return BaseAsset.allCases[row].rawValue
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        delegate?.baseAsset = BaseAsset.allCases[row]
        delegate?.fetchData()
    }
}
