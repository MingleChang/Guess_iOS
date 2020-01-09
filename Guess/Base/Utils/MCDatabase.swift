//
//  MCDatabase.swift
//  Guess
//
//  Created by MingleChang on 2020/1/2.
//  Copyright © 2020 MingleChang. All rights reserved.
//

import Foundation
import GRDB

struct MCDatabase {
    static let singleton: MCDatabase = MCDatabase()
    static func share() -> MCDatabase {
        return self.singleton
    }
    
    let database: DatabaseQueue
    let wordColumn: Column = Column("word")
    let categoryColumn: Column = Column("category")
    let languageColumn: Column = Column("language")
    let versionColumn: Column = Column("version")
    
    init() {
        let lPath: String = Bundle.main.path(forResource: "sqlite", ofType: "db") ?? ""
        database = try! DatabaseQueue(path: lPath)
    }
    
    func queryCategories(language: String) -> [String] {
        var lResult: [String] = []
        database.read { db in
            let lRequest = MCWordModel.select(categoryColumn).filter(languageColumn==language).group(categoryColumn)
            lResult = (try? String.fetchAll(db, lRequest)) ?? []
        }
        return lResult
    }
    
    func queryWords(category: String, language: String) -> [MCWordModel] {
        var lResult: [MCWordModel] = []
        database.read { db in
            lResult = (try? MCWordModel.filter((category=="" || categoryColumn==category) && languageColumn==language).order(sql: "RANDOM()").limit(100).fetchAll(db)) ?? []
        }
        return lResult
    }
}
