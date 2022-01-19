//
//  MainTableViewCell.swift
//  MyExchange
//
//  Created by Hüsnü Taş on 18.01.2022.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    
    static let identifier = "mainCell"
    
    lazy var label: UILabel = {
        let label = UILabel()
        return label
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    

}
