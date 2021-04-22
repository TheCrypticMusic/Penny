//
//  BudgetView.swift
//  TestingViews
//
//  Created by Daniel Gibson on 08/04/2021.
//

import SwiftUI




struct BudgetView: View {
    
    init() {
        
        UINavigationBar.appearance().tintColor = UIColor(.buttonColour)
        UINavigationBar.appearance().barTintColor = UIColor(named: "cardBackground")
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(named: "Headline") as Any]
        
        UITableView.appearance().backgroundColor = UIColor(named: "cardForeground")
        
    }
    
    @ObservedObject var expenses = Expenses()
    

    
    @State private var isIncome = false
    @State private var isOutgoing = false
    @State private var isBudget = false
    
    func delete(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
    
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.cardBackground.ignoresSafeArea()
                    .navigationBarItems(trailing:
                                            Image(systemName: "heart.fill").foregroundColor(.buttonColour)).toolbar {
                                                
                                                ToolbarItem(placement: .principal) {
                                                    
                                                    VStack {
                                                        Text("PENNY")
                                                            .fontWeight(.bold)
                                                            .font(.largeTitle)
                                                            .foregroundColor(.headlineText)
                                                            .kerning(5)
                                                    }
                                                }
                                            }
                VStack {
                    Text("Your Current Budget").foregroundColor(.paragraphText).padding(.bottom)
                    
                    if isBudget {
                        Text("£\(expenses.expensesBudget())")
                            .fontWeight(.bold)
                            .font(.largeTitle)
                            .foregroundColor(.headlineText)
                            .kerning(3)
                            .transition(.offset(x: 0, y: 20).combined(with: .opacity))
                    }
                    
                    if !isBudget {
                        Text("£\(expenses.expensesBudget())")
                            .fontWeight(.bold)
                            .font(.largeTitle)
                            .foregroundColor(.headlineText)
                            .kerning(3)
                            .transition(.offset(x: 0, y: 20).combined(with: .opacity))
                    }
                    HStack {
                        Spacer()
                        
                        Text("In:")
                            .foregroundColor(.paragraphText)
                            .font(.title2)
                        if isIncome {
                            Text("£\(expenses.expensesIncome())")
                                .foregroundColor(.greenIncome)
                                .font(.title2)
                                .transition(.offset(x: 0, y: 20).combined(with: .opacity))
                            
                        }
                        if !isIncome {
                            Text("£\(expenses.expensesIncome())")
                                .foregroundColor(.greenIncome)
                                .font(.title2)
                                //
                                .transition(.offset(x: 0, y: 20).combined(with: .opacity))
                        }
                        Spacer()
                        Text("Out:")
                            .foregroundColor(.paragraphText)
                            .font(.title2)
                        if isOutgoing {
                            Text("£\(expenses.expensesOutgoing())")
                                .foregroundColor(.buttonColour)
                                .font(.title2)
                                .transition(.offset(x: 0, y: -20).combined(with: .opacity))
                            
                        }
                        if !isOutgoing {
                            Text("£\(expenses.expensesOutgoing())")
                                .foregroundColor(.buttonColour)
                                .font(.title2)
                                .transition(.offset(x: 0, y: -20).combined(with: .opacity))
                        }
                        Spacer()
                    }
                    .padding()
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Add Expenses")
                                .foregroundColor(.headlineText)
                                .font(.title)
                                .fontWeight(.bold)
                                .padding()
                            Spacer()
                            NavigationLink(
                                destination: ExpenseView(expenses: self.expenses),
                                label: {
                                    Image(systemName: "plus")
                                        .foregroundColor(.buttonColour)
                                        .padding()
                                })
                        }
                        
                        
                        Text("Add your income and outgoings")
                            .foregroundColor(.paragraphText)
                            .padding(.leading)
                        Divider()
                            .background(Color.buttonColour)
                            
                            .padding()
                        List {
                            Text("Income")
                                .foregroundColor(.headlineText)
                                .font(.title)
                                .fontWeight(.bold)
                                .listRowBackground(Color.cardForeground)
                            
                            ForEach(expenses.items) { ex in
                                
                                if ex.expenseType == "Income" {
                                    
                                    HStack {
                                        
                                        
                                        Text("\(ex.expenseName)").foregroundColor(.paragraphText)
                                            .font(.title2)
                                        
                                        
                                        Spacer()
                                        Text("£\(ex.expenseAmount)")
                                            .foregroundColor(.paragraphText)
                                            .padding(.trailing)
                                            .font(.title2)
                                    }
                                }
                                
                            }
                            .onDelete(perform: { IndexSet in
                                delete(at: IndexSet)
                                withAnimation(.easeInOut) {
                                    self.isIncome.toggle()
                                    self.isBudget.toggle()
                                }
                            })
                            .listRowBackground(Color.cardForeground)
                        }
                        .listStyle(InsetListStyle())
                        Divider()
                            .background(Color.buttonColour)
                            .padding()
                        List {
                            
                            Text("Outgoings")
                                .foregroundColor(.headlineText)
                                .font(.title)
                                .fontWeight(.bold)
                                .listRowBackground(Color.cardForeground)
                            
                            ForEach(expenses.items) { ex in
                                
                                if ex.expenseType == "Outgoing" {
                                    
                                    HStack {
                                        Text("\(ex.expenseName)").foregroundColor(.paragraphText)
                                            .font(.title2)
                                        Spacer()
                                        Text("£\(ex.expenseAmount)")
                                            .foregroundColor(.paragraphText)
                                            .padding(.trailing)
                                            .font(.title2)
                                        
                                    }
                                }
                            }
                            
                            .onDelete(perform: { IndexSet in
                                delete(at: IndexSet)
                                withAnimation(.easeInOut) {
                                    self.isOutgoing.toggle()
                                    self.isBudget.toggle()
                                }
                            })
                            .listRowBackground(Color.cardForeground)
                        }.listRowInsets(.some(EdgeInsets()))
                        
                    }.listStyle(InsetListStyle())
                    .background(Rectangle().fill(Color.cardForeground))
                    
                    
                    .cornerRadius(20)
                    .edgesIgnoringSafeArea(.bottom)
                }
            }
        }
    }
}

struct BudgetView_Previews: PreviewProvider {
    static var previews: some View {
        BudgetView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 12"))
            .previewDisplayName("iPhone 12")
        
        BudgetView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
            .previewDisplayName("iPhone 8")
    }
}
