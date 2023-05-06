//
//  Expenses.swift
//  iExpense
//
//  Created by Nilesh Rathod on 05/05/23.
//

import Foundation


class Expenses  : ObservableObject {
    
    @Published var items = [ExpenseItem]() {
        didSet {
            let encoder = JSONEncoder()
            if let encode = try? encoder.encode(items){
                UserDefaults.standard.set(encode, forKey: "ITEMS")
            }
        }
    }
    
    init() {
        if let savedItem = UserDefaults.standard.data(forKey: "ITEMS"){
            if let decodeItem = try? JSONDecoder().decode([ExpenseItem].self, from: savedItem) {
                items = decodeItem
                return
            }
                
        }
        
        items = [ExpenseItem]()
    }
    
    
}
