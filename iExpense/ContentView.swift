//
//  ContentView.swift
//  iExpense
//
//  Created by Nilesh Rathod on 04/05/23.
//

import SwiftUI

struct ExpensesItemView : View {
    let item :ExpenseItem
    
    var body: some View{
        HStack {
            
            let currencyCode = Locale.current.currency?.identifier ?? "USD"
            
            VStack(alignment: .leading) {
                Text("\(item.name)")
                    .font(.headline)
                Text(item.type)
            }
            
            Spacer()
            Text(item.amount, format: .currency(code: currencyCode))
        }
        .padding(20)
        .background(item.amount < 100 ? .green : item.amount < 200 ? .blue : .red)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}
struct ContentView: View {
    @StateObject var expenses =  Expenses()
    @State private var showingAddView = false
    
     var personalItems: [ExpenseItem]  {
        expenses.items.filter { $0.type == "Personal"}
    }
    
    var businessExpensesItems: [ExpenseItem] {
        expenses.items.filter { $0.type == "Bussiness"}
    }
    
    var body: some View {
        NavigationView {
            
            List {
                Section("Personal"){
                    ForEach(personalItems , id: \.id) { item in
                        ExpensesItemView(item: item)
                    }
                    .onDelete(perform: removePersonalExpenseItem)
                }
                
                Section("Bussiness") {
                    ForEach(businessExpensesItems , id: \.id) { item in
                        ExpensesItemView(item: item)
                    }
                    .onDelete(perform: removeBusinessExpenseItem)
                }
                .navigationTitle("iExpense")
                .toolbar {
                    Button {
                        showingAddView = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                .sheet(isPresented: $showingAddView){
                    AddView(expenses: expenses)
                }
            }
        }
    }
    
    func removePersonalExpenseItem(at offset:IndexSet){
        for index in offset {
            let item = personalItems[index]
            expenses.items.removeAll(where: { $0.id == item.id })
        }
        
    }
    
    func removeBusinessExpenseItem(at offset:IndexSet){
        for index in offset {
            let item = businessExpensesItems[index]
            expenses.items.removeAll(where: { $0.id == item.id })
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
