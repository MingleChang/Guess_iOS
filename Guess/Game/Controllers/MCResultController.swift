//
//  MCResultController.swift
//  Guess
//
//  Created by MingleChang on 2020/1/6.
//  Copyright © 2020 MingleChang. All rights reserved.
//

import UIKit

class MCResultController: MCViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
}
// MARK: - Configure
extension MCResultController {
    func configure() {
        configureView()
        configureData()
    }
    func configureView() {
    }
    func configureData() {
    }
}

// MARK: - Override
extension MCResultController {
    override var shouldAutorotate: Bool {
        return true
    }
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return .landscapeLeft
    }
}
