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
    
    let table = Table("Transactions")
    
    let id = Expression<Int64>("id")
    let value = Expression<Float64>("value")
    let account = Expression<String>("account")
    let category = Expression<String>("category")
    let description = Expression<String>("description")
    
    init(){
        do{
            let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            db = try Connection("\(path)/score.sqlite3")
            try db?.run(table.create(ifNotExists: true){
                t in
                t.column(id,primaryKey: .autoincrement)
                t.column(value)
                t.column(account)
                t.column(category)
                t.column(description)
            })
        }catch{
            print(error)
        }
    }
    
    func insertTransactionEntry(transactionEntry:TransactionEntry) -> Bool {
        guard let db = db
        else {
            return false
        }
        
        do {
            let rowId = try db.run(
                table.insert(
                    value <- transactionEntry.value,
                    account <- transactionEntry.account,
                    category <- transactionEntry.category,
                    description <- transactionEntry.description
                )
            )
            
            if rowId > 0 {
                return true
            }
        } catch {
            print(error)
        }
        
        return false
    }
}
