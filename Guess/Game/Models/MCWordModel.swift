//
//  MCWordModel.swift
//  Guess
//
//  Created by MingleChang on 2020/1/7.
//  Copyright © 2020 MingleChang. All rights reserved.
//

import Foundation
import GRDB

enum MCWordResult: String, CaseIterable, Codable, Hashable {
    case normal = "Normal"
    case right = "Right"
    case skip = "Skip"
    case timeout = "Timeout"
}
struct MCWordModel: FetchableRecord, PersistableRecord, TableRecord, Hashable, Codable {
    var word: String = ""
    var category: String = ""
    var language: String = ""
    var version: String = ""
    var resutlt: MCWordResult = .normal
    
    init(row: Row) {
        word = row["word"]
        category = row["category"]
        language = row["language"]
        version = row["version"]
        resutlt = .normal
    }
    
    static var databaseTableName: String {
        get {
            return "words"
        }
        
    }
}
