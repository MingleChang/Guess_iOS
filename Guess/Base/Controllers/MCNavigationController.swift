//
//  MCNavigationController.swift
//  Guess
//
//  Created by MingleChang on 2019/12/30.
//  Copyright © 2019 MingleChang. All rights reserved.
//

import UIKit

class MCNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
extension MCNavigationController {
    override var shouldAutorotate: Bool {
        return topViewController?.shouldAutorotate ?? false
    }
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return topViewController?.supportedInterfaceOrientations ?? .portrait
    }
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return topViewController?.preferredInterfaceOrientationForPresentation ?? .portrait
    }
}
