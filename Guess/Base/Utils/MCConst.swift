//
//  MCConst.swift
//  Guess
//
//  Created by MingleChang on 2019/12/31.
//  Copyright © 2019 MingleChang. All rights reserved.
//

import Foundation

typealias MCVoidCallBack = ()->(Void)

typealias MCUserDefaultKey = String
let MCUserDefaultLanguage: MCUserDefaultKey = "MCUserDefaultLanguageKey"

extension Notification.Name {
    static let MCNotificationLanguageChange = Notification.Name("MCNotificationLanguageChange")
}
