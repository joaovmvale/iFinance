//
//  SQLiteDatabase.swift
//  QuizApp
//
//  Created by ALUNO on 20/04/22.
//

import Foundation
import SQLite

class SQLiteDatabase{
    var db:Connection?
    
    let table = Table("Score")
    
    let id = Expression<Int64>("id")
    let name = Expression<String>("name")
    let score = Expression<Int>("score")
    
    init(){
        do{
            let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            db = try Connection("\(path)/score.sqlite3")
            try db?.run(table.create(ifNotExists: true){
                t in
                t.column(id,primaryKey: .autoincrement)
                t.column(name)
                t.column(score)
            })
        }catch{
            print(error)
        }
    }
    func insertScoreEntry(scoreEntry:ScoreEntry) -> Bool{
        guard let db = db else{
            return false
        }
        do{
            let rowId = try db.run(table.insert(
                name <- scoreEntry.name,
                score <- scoreEntry.score
            ))
            if rowId > 0{
                return true
            }
        }catch{
            print(error)
        }
        return false
    }
    func getScoreEntries() -> [ScoreEntry]{
        var scores = [ScoreEntry]()
        if let db = db{
            do{
                for row in try db.prepare(table.select(name,score).order(score.desc)){
                    scores.append(ScoreEntry(name: row[name], score: row[score]))
                }
            }catch{
                print(error)
            }
        }
        return scores
    }
}
