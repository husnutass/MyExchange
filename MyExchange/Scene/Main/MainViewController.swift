//
//  MainViewController.swift
//  MyExchange
//
//  Created by Hüsnü Taş on 18.01.2022.
//

import UIKit

class MainViewController: UIViewController {
    
    private var viewModel: MainViewModel!
    
    var exchangeRates = [Rate]()
    var baseAsset: BaseAsset = .usd
    
    private var mainTableView = UITableView()
    
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
    func fetchData() {
        mainView.startAnimating()
        viewModel.fetchExchangeRates(with: baseAsset, completion: exchangeRatesHandler)
    }
    
    lazy var exchangeRatesHandler: ExchangeRatesCompletionBlock = { [weak self] response in
        DispatchQueue.main.async {
            switch response {
            case .success(let data):
                guard let data = data else { return }
                self?.exchangeRates = data.rates
            case .failure(let error):
                let errorResponse = error as? ErrorResponse
                self?.showAlert(title: "Error", message: errorResponse?.errorMessage)
            }
            self?.mainTableView.reloadData()
            self?.mainView.stopAnimating()
        }
    }
    
}
