//
//  MainViewDataProtocol.swift
//  MyExchange
//
//  Created by Hüsnü Taş on 6.04.2022.
//

import Foundation

protocol MainViewDataProtocol {
    func getNumberOfRowsInSection() -> Int
    func getCellData(at index: Int) -> Rate
    func selectBaseAsset(at row: Int)
}
