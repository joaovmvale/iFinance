//
//  DumbModel.swift
//  iFinance
//
//  Created by ALUNO on 04/05/22.
//

import Foundation

class TransactionEntry {
    internal init(value: Float64, account: String, category: String, description: String) {
        self.value = value
        self.account = account
        self.category = category
        self.description = description
    }
    
    var value:Float64
    var account:String
    var category:String
    var description:String
}
