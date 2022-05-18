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
    let flow = Expression<Int>("flow")
    
    init(){
        do{
            let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            db = try Connection("\(path)/ifinance.sqlite3")
            try db?.run(table.create(ifNotExists: true){
                t in
                t.column(id,primaryKey: .autoincrement)
                t.column(value)
                t.column(account)
                t.column(category)
                t.column(description)
                t.column(flow)
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
                    description <- transactionEntry.description,
                    flow <- transactionEntry.flow
                )
            )
            
            if rowId > 0 {
                return true
            }
        } catch {
            print(error)
            return false
        }
        
        return false
    }
    
    func getTransactionsEntries() -> [TransactionEntry]{
        var transactions = [TransactionEntry]()
        
        if let db = db{
            do{
                for row in try db.prepare(table.select(id, value, account, category, description, flow).order(id.desc)){
                    transactions.append(TransactionEntry(value: row[value], account: row[account], category: row[category], description: row[description], flow: row[flow]))
                }
            } catch {
                print(error)
                return []
            }
        }
        
        return transactions
    }
    
    func getIncomeList() -> [Float64] {
        var incomeList: [Float64] = []
        
        if let db = db{
            do{
                for row in try db.prepare(
                    table.select(id, value, flow)
                        .order(id.desc)
                        .where(flow == 1)
                ){
                    incomeList.append(row[value])
                }
            } catch {
                print(error)
                return []
            }
        }
        
        return incomeList
    }
    
    func getExpenseList() -> [Float64] {
        var expenseList: [Float64] = []
        
        if let db = db{
            do{
                for row in try db.prepare(
                    table.select(id, value, flow)
                        .order(id.desc)
                        .where(flow == 2)
                ){
                    expenseList.append(row[value])
                }
            } catch {
                print(error)
                return []
            }
        }
        
        return expenseList
    }
}
