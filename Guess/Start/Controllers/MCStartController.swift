//
//  MCStartController.swift
//  Guess
//
//  Created by MingleChang on 2019/12/30.
//  Copyright © 2019 MingleChang. All rights reserved.
//

import UIKit
import SnapKit

class MCStartController: MCViewController {
    private let startButton: UIButton = UIButton()
    private let settingButton: UIButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    override func languageChange() {
        startButton.setTitle(MCLocalized("Start"), for: .normal)
        settingButton.setTitle(MCLocalized("Setting"), for: .normal)
    }
    
}
// MARK: - Private
extension MCStartController {
    private func toMenuController() {
        let lViewController = MCMenuController()
        navigationController?.pushViewController(lViewController, animated: true)
    }
    private func toSettingController() {
        let lViewController = MCSettingController()
        navigationController?.pushViewController(lViewController, animated: true)
    }
}
// MARK: - Event Response
extension MCStartController {
    @objc func startButtonClick(_ sender: UIButton) {
        toMenuController()
    }
    @objc func settingButtonClick(_ sender: UIButton) {
        toSettingController()
    }
}

// MARK: - Configure
extension MCStartController {
    func configure() {
        configureView()
        configureData()
    }
    func configureView() {
        startButton.setTitleColor(UIColor.white, for: .normal)
        startButton.titleLabel?.font = MCMarkerFeltWideFont(50)
        startButton.setTitle(MCLocalized("Start"), for: .normal)
        startButton.addTarget(self, action: #selector(startButtonClick(_:)), for: .touchUpInside)
        view.addSubview(startButton)
        startButton.snp.makeConstraints { make in
            make.center.equalTo(view)
        }
        
        settingButton.setTitleColor(UIColor.white, for: .normal)
        settingButton.titleLabel?.font = MCMarkerFeltWideFont(20)
        settingButton.setTitle(MCLocalized("Settings"), for: .normal)
        settingButton.addTarget(self, action: #selector(settingButtonClick(_:)), for: .touchUpInside)
        view.addSubview(settingButton)
        settingButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right).offset(-MCPixelRatio(20))
        }
    }
    func configureData() {
        
    }
}
