//
//  MainViewController.swift
//  MyExchange
//
//  Created by Hüsnü Taş on 18.01.2022.
//

import UIKit

typealias ExchangeRatesCompletionBlock = (ExchangeRatesResponse?) -> ()

class MainViewController: UIViewController {
    
    private var viewModel: MainViewModel!
    
    private var exchangeRates = [Rate]()
    private var baseAsset: BaseAsset = .usd
    
    private var mainTableView = UITableView()
    
    private lazy var mainStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [basePickerView, mainTableView])
        view.axis = .vertical
        view.alignment = .fill
        view.spacing = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var basePickerView: UIPickerView = {
        let picker = UIPickerView()
        picker.delegate = self
        picker.dataSource = self
        picker.userActivity?.title = "Base"
        picker.backgroundColor = .systemBackground
        return picker
    }()
    
    private lazy var activityIndicatorView: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        return indicator
    }()
    
    convenience init(viewModel: MainViewModel) {
        self.init()
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        fetchData()
        addComponents()
        configureView()
    }
    
    private func addComponents() {
        mainTableView.translatesAutoresizingMaskIntoConstraints = false
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.identifier)
        view.addSubview(mainStackView)
    }
    
    private func configureView() {
        mainStackView.expandViewWithSafeArea(to: view)
    }
    
    private func fetchData() {
        viewModel.fetchExchangeRates(with: baseAsset, completion: exchangeRatesHandler)
    }
    
    lazy var exchangeRatesHandler: ExchangeRatesCompletionBlock = { [weak self] response in
        DispatchQueue.main.async {
            guard let response = response else { return }
            self?.exchangeRates = response.rates
            self?.mainTableView.reloadData()
        }
    }
    
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exchangeRates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.identifier) as? MainTableViewCell else { return UITableViewCell() }
        cell.setData(cellData: exchangeRates[indexPath.row])
        return cell
    }
}

extension MainViewController: UIPickerViewDelegate, UIPickerViewDataSource {
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
        baseAsset = BaseAsset.allCases[row]
        fetchData()
    }
}
