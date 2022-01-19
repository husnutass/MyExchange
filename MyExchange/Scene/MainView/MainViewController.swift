//
//  MainViewController.swift
//  MyExchange
//
//  Created by Hüsnü Taş on 18.01.2022.
//

import UIKit

class MainViewController: UIViewController {
    
    private var viewModel: MainViewModel!
    
    private var mainTableView = UITableView()
  
    convenience init(viewModel: MainViewModel) {
        self.init()
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "MyExchange"
        view.backgroundColor = .red
        addComponents()
        configureView()
    }
    
    private func addComponents() {
        mainTableView.translatesAutoresizingMaskIntoConstraints = false
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.identifier)
        view.addSubview(mainTableView)
    }
    
    private func configureView() {
        mainTableView.expandView(to: view)
    }


}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.identifier) as? MainTableViewCell else { return UITableViewCell() }
        return cell
    }
}
