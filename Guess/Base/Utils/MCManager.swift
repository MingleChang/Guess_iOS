//
//  MCManager.swift
//  Guess
//
//  Created by MingleChang on 2019/12/30.
//  Copyright © 2019 MingleChang. All rights reserved.
//

import UIKit



class MCManager {
    private static let singleton: MCManager = MCManager()
    class func share() -> MCManager {
        return self.singleton
    }
    
    var appDelegate: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    var language: MCLanguage {
        didSet {
            NotificationCenter.default.post(name: .MCNotificationLanguageChange, object: nil)
        }
    }
    var languageBundle: Bundle
    
    var categories: [String] {
        get {
            var lCategories = MCDatabase.share().queryCategories(language: language.rawValue)
            lCategories.insert(MCLocalized("All"), at: 0)
            return lCategories
        }
    }
    
    init() {
        language = MCUtils.localLanguage
        languageBundle = MCUtils.localBundle(language)
    }
    
    func changeLanguage(_ lang: MCLanguage) {
        language = lang
        MCUtils.saveLocalLanguage(language)
        languageBundle = MCUtils.localBundle(language)
    }
    
    func replaceRootController(_ controller: UIViewController) {
        if (controller.isKind(of: MCNavigationController.self)) {
            appDelegate.window?.rootViewController = controller
        }else {
            appDelegate.window?.rootViewController = MCNavigationController(rootViewController: controller)
        }
    }
}
