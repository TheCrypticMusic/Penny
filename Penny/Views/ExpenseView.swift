//
//  ExpenseView.swift
//  TestingViews
//
//  Created by Daniel Gibson on 10/04/2021.
//

import SwiftUI


struct ExpenseView: View {
    
    
    
    var expenseType = ["Income", "Outgoings"]
    @State private var expenseName = ""
    @State private var expenseTotal = ""
    @State private var selectedExpense = "Income"
    @State private var showingAlert = false
    func onAdd() {
        self.expenseName = ""
        self.expenseTotal = ""
    }
    
    
    @ObservedObject var expenses = Expenses()
    
    var body: some View {
        ZStack {
            Color.cardBackground.ignoresSafeArea()
            VStack {
                GeometryReader { geo in
                    Image("expense_screen_logo")
                        .resizable()
                        
                        .scaledToFill()
                        
                        .padding()
                    }
                VStack {
                    Picker("Expense Type", selection: $selectedExpense) {
                        ForEach(expenseType, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                    .background(Color.clear)
                    VStack {
                        TextField("Expense Name", text: $expenseName)
                            .keyboardType(.alphabet)
                        TextField("Amount", text:$expenseTotal)
                            .keyboardType(.decimalPad)
                        
                    }.textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    
                    Button("Add Expense") {
                        
                        let ex = ExpenseItem(expenseName: "\(expenseName)", expenseAmount: Int(expenseTotal) ?? 0, expenseType: selectedExpense)
                        self.expenses.items.append(ex)
                        showingAlert = true
                    }.alert(isPresented: $showingAlert) {
                        Alert(title: Text("Expense Added"), message:  Text("\(expenseName) added to \(selectedExpense)"), dismissButton: .default(Text("Ok"), action: onAdd))
                    }
                    .disabled(expenseName.isEmpty || expenseTotal.isEmpty)
                    
                    
                    .frame(width: 350, height: 50)
                    .background(Color.buttonColour)
                    .foregroundColor(Color.cardBackground)
                    .cornerRadius(50)
                    .padding()
                    Spacer()
                }.background(Rectangle().fill(Color.cardBackground))
                .cornerRadius(20)
                
                
            }
        }.navigationBarTitle("EXPENSES", displayMode: .inline)
    }
}





struct ExpenseView_Previews: PreviewProvider {
    static var previews: some View {
        
        ExpenseView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 12"))
            .previewDisplayName("iPhone 12")
        
        
        NavigationView {
            
            ExpenseView()
                .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
                .previewDisplayName("iPhone 8")
        }
        
        
    }
}
