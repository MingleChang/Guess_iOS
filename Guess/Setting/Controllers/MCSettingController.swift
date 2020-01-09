//
//  MCSettingController.swift
//  Guess
//
//  Created by MingleChang on 2019/12/31.
//  Copyright © 2019 MingleChang. All rights reserved.
//

import UIKit

class MCSettingController: MCViewController {
    private let navigationBar: MCNavigationBar = MCNavigationBar()
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

}
// MARK: - Configure
extension MCSettingController {
    func configure() {
        configureView()
        configureData()
    }
    func configureView() {
        navigationBar.title = MCLocalized("Settings")
        navigationBar.backButtonCallBack = {[unowned self] ()->(Void) in
            self.navigationController?.popViewController(animated: true)
        }
        view.addSubview(navigationBar)
        navigationBar.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right)
            make.height.equalTo(MCPixelRatio(44))
        }
    }
    func configureData() {
    }
}
