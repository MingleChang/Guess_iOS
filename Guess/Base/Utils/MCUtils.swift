//
//  MCUtils.swift
//  Guess
//
//  Created by MingleChang on 2019/12/30.
//  Copyright © 2019 MingleChang. All rights reserved.
//

import UIKit

func MCLog<T>(_ log: T, file: String = #file, function: String = #function, line: Int = #line, column: Int = #column) {
#if DEBUG
    let fileName = (file as NSString).lastPathComponent
    print("file:\(fileName)\nfunction:\(function)\nline:\(line)\ncolumn:\(column)\nlog:\(log)")
#endif
}

let MCScreenBounds = UIScreen.main.bounds
let MCScreenSize = MCScreenBounds.size
let MCScreenWidth = MCScreenSize.width
let MCScreenHeight = MCScreenSize.height

let MCMinScreenSide = min(MCScreenWidth, MCScreenHeight)
let MCMaxScreenSide = max(MCScreenWidth, MCScreenHeight)

let MCPixelRatioValue = MCMinScreenSide / 375.0


func MCPixelRatio(_ pixel: Double) -> Double {
    return ceil(pixel * Double(MCPixelRatioValue))
}

func MCLocalized(_ text: String) -> String {
    return NSLocalizedString(text, tableName: nil, bundle: MCManager.share().languageBundle, value: text, comment: text)
}

func MCMarkerFeltWideFont(_ size: Double) -> UIFont {
    return UIFont(name: "MarkerFelt-Wide", size: CGFloat(MCPixelRatio(size)))!
}
func MCFormatTimeCount(_ time: Int) -> String {
    let seconds = time % 60
    let minutes = time / 60
    let result = String(format: "%02d", minutes) + "'" + String(format: "%02d",seconds) + "\""
    return result
}
enum MCLanguage: String {
    case English="en"
    case Chinese="zh"
}

class MCUtils {
    static var localLanguage: MCLanguage {
        var lLanguage: MCLanguage?
        if let lLocalLanguage = UserDefaults.standard .string(forKey: MCUserDefaultLanguage) {
            lLanguage = MCLanguage(rawValue: lLocalLanguage)
        }else {
            let lLocal = NSLocale.current.identifier
            if lLocal.hasPrefix("en") {
                lLanguage = .English
            }else {
                lLanguage = .Chinese
            }
        }
        return lLanguage ?? .Chinese
    }
    
    static func saveLocalLanguage(_ language: MCLanguage) {
        UserDefaults.standard.set(language.rawValue, forKey: MCUserDefaultLanguage)
        UserDefaults.standard.synchronize()
    }
    
    static func localBundle(_ language: MCLanguage) -> Bundle{
        guard let lPath = Bundle.main.path(forResource: language.rawValue, ofType: "lproj") else {
            return Bundle.main
        }
        let lBundle = Bundle(path: lPath)
        return lBundle ?? Bundle.main
    }
}
