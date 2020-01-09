//
//  MCMenuCategoryCell.swift
//  Guess
//
//  Created by MingleChang on 2020/1/9.
//  Copyright © 2020 MingleChang. All rights reserved.
//

import UIKit

class MCMenuCategoryCell: UITableViewCell {
    private let categoryLabel: UILabel = UILabel()
    
    var category: String {
        get {
            return categoryLabel.text ?? ""
        }
        set {
            categoryLabel.text = newValue
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }

}
// MARK: - Configure
extension MCMenuCategoryCell {
    func configure() {
        configureView()
        configureData()
    }
    func configureView() {
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
        
        categoryLabel.textColor = UIColor.white
        categoryLabel.font = MCMarkerFeltWideFont(30)
        categoryLabel.textAlignment = .center
        contentView.addSubview(categoryLabel)
        categoryLabel.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
    }
    func configureData() {
    }
}
