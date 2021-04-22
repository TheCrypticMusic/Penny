import Foundation
import SwiftUI

struct ExpenseItem: Identifiable {
    let id = UUID()
    let expenseName: String
    let expenseAmount: Int
    let expenseType: String
    
    
}

class Expenses: ObservableObject {
    
    @Published var items = [
        ExpenseItem(expenseName: "Wage", expenseAmount: 3000, expenseType: "Income"),
        ExpenseItem(expenseName: "Food", expenseAmount: 70, expenseType: "Outgoing"),
        ExpenseItem(expenseName: "Stocks", expenseAmount: 250, expenseType: "Income"),
        ExpenseItem(expenseName: "Rent", expenseAmount: 900, expenseType: "Outgoing"),
        ExpenseItem(expenseName: "Wage", expenseAmount: 3000, expenseType: "Income"),
        ExpenseItem(expenseName: "Food", expenseAmount: 70, expenseType: "Outgoing"),
        ExpenseItem(expenseName: "Stocks", expenseAmount: 250, expenseType: "Income"),
        ExpenseItem(expenseName: "Rent", expenseAmount: 900, expenseType: "Outgoing"),
        
    ]
    
    func expensesBreakdown() -> Dictionary<String, Int> {
        var income = 0
        var outgoing = 0
        for i in items {
            
            if i.expenseType == "Income" {
                income += i.expenseAmount
                
            } else {
                outgoing += i.expenseAmount
            }
            
        }
        
        return ["Income": income, "Outgoing": outgoing, "Budget": income - outgoing]
        
    }
    
    func expensesIncome() -> Int {
        var income = 0
        for expense in items {
            if expense.expenseType == "Income" {
                income += expense.expenseAmount
            }
        }
        return income
    }
    
    func expensesOutgoing() -> Int {
        var outgoing = 0
        for expense in items {
            if expense.expenseType == "Outgoing" {
                outgoing += expense.expenseAmount
            }
        }
        return outgoing
    }
    
    func expensesBudget() -> Int {
        return expensesIncome() - expensesOutgoing()
    }
    
}



