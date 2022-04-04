//
//  MainViewBuilder.swift
//  MyExchange
//
//  Created by Hüsnü Taş on 18.01.2022.
//

import Foundation

class MainViewBuilder {
    
    class func build(viewModel: MainViewModel) -> MainViewController {
        return MainViewController(viewModel: viewModel)
    }
    
}
