//
//  MCViewController.swift
//  Guess
//
//  Created by MingleChang on 2019/12/30.
//  Copyright © 2019 MingleChang. All rights reserved.
//

import UIKit

class MCViewController: UIViewController {
    deinit {
        MCLog(String(format: "%@", self) + "deinit")
        NotificationCenter.default.removeObserver(self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(languageChangeNotification(_:)), name: .MCNotificationLanguageChange, object: nil)
        view.backgroundColor = UIColor(named: "Primary")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
    }
    // MARK: - Overriding
    func languageChange() {
        
    }
}
//MARK: - Notification
extension MCViewController {
    @objc func languageChangeNotification(_ sender: Notification) {
        languageChange()
    }
}

// MARK: - Override
extension MCViewController {
    override var prefersStatusBarHidden: Bool {
        return true
    }
    override var shouldAutorotate: Bool {
        return true
    }
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return .portrait
    }
    
}
