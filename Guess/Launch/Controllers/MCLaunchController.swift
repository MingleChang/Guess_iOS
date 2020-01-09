//
//  MCLaunchController.swift
//  Guess
//
//  Created by MingleChang on 2019/12/30.
//  Copyright © 2019 MingleChang. All rights reserved.
//

import UIKit
import CoreMotion
class MCLaunchController: MCViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        MCManager.share().replaceRootController(MCStartController())
    }
}
