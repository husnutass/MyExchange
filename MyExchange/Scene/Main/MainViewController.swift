//
//  MainViewController.swift
//  MyExchange
//
//  Created by Hüsnü Taş on 18.01.2022.
//

import UIKit

class MainViewController: UIViewController {
    
    private var viewModel: MainViewModel!
    
    private lazy var mainView: MainView = {
        let view = MainView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        return view
    }()
    
    convenience init(viewModel: MainViewModel) {
        self.init()
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        subscribeData()
        fetchData()
        addComponents()
        configureView()
    }
    
    // MARK: - UI Configurations
    private func addComponents() {
        view.addSubview(mainView)
    }
    
    private func configureView() {
        mainView.expandViewWithSafeArea(to: view)
    }
    
    // MARK: - Data Handling
    private func fetchData() {
        mainView.startAnimating()
        viewModel.fetchExchangeRates()
    }
    
    private func subscribeData() {
        viewModel.subscribeExchangeRates(completion: exchangeRatesResponseHandler)
    }
    
    lazy var exchangeRatesResponseHandler: ExchangeRatesResponseBlock = { [weak self] error in
        DispatchQueue.main.async {
            self?.mainView.reloadData()
            guard let error = error else { return }
            self?.showAlert(title: "Error", message: error.errorMessage)
        }
    }
    
}

// MARK: - MainViewDataProtocol
extension MainViewController: MainViewDataProtocol {
    func getNumberOfRowsInSection() -> Int {
        return viewModel.exchangeRates.count
    }
    
    func getCellData(at index: Int) -> Rate {
        return viewModel.exchangeRates[index]
    }
    
    func selectBaseAsset(at row: Int) {
        viewModel.baseAsset = BaseAsset.allCases[row]
        fetchData()
    }
}
