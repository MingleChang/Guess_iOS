//
//  MCNavigationBar.swift
//  Guess
//
//  Created by MingleChang on 2020/1/2.
//  Copyright © 2020 MingleChang. All rights reserved.
//

import UIKit

class MCNavigationBar: UIView {
    private let titleLabel = UILabel()
    private let backButton = UIButton()
    
    var backButtonCallBack: MCVoidCallBack? = nil
    
    var title: String {
        get {
            return titleLabel.text ?? ""
        }
        set {
            titleLabel.text = newValue
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
// MARK: - Private
extension MCNavigationBar {
    private func clickBackButton() {
        if (backButtonCallBack != nil) {
            backButtonCallBack!()
        }
    }
}
// MARK: - Event Response
extension MCNavigationBar {
    @objc func backButtonClick(_ sender: UIButton) {
        clickBackButton()
    }
}
// MARK: - Configure
extension MCNavigationBar {
    func configure() {
        configureView()
        configureData()
    }
    func configureView() {
        titleLabel.font = MCMarkerFeltWideFont(24)
        titleLabel.textColor = UIColor.white
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        
        backButton.titleLabel?.font = MCMarkerFeltWideFont(20)
        backButton.setTitleColor(UIColor.white, for: .normal)
        backButton.setTitle(MCLocalized("Back"), for: .normal)
        backButton.addTarget(self, action: #selector(backButtonClick(_:)), for: .touchUpInside)
        addSubview(backButton)
        backButton.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(MCPixelRatio(20))
            make.top.bottom.equalToSuperview()
        }
    }
    func configureData() {
    }
}
