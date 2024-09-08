//
//  ContentView.swift
//  Easy Tip
//
//  Created by Hannah Jacob on 6/20/24.
//

import SwiftUI
struct ContentView: View {
    @State private var amount: String = ""
    @State private var tipPercentages: [Int] = FileManager.default.readTipPercentages()
    @State private var newTipPercentage: String = ""
    @FocusState private var amountIsFocused: Bool
    
    func calculateTipAmount(orderAmount: Double, tipPercentage: Int) -> Double {
        return orderAmount * Double(tipPercentage) / 100
    }
    
    func calculateTotalAmount(orderAmount: Double, tipPercentage: Int) -> Double {
        return orderAmount + calculateTipAmount(orderAmount: orderAmount, tipPercentage: tipPercentage)
    }
    
    func addTipPercentage() {
        if let newPercentage = Int(newTipPercentage), !tipPercentages.contains(newPercentage) {
            tipPercentages.append(newPercentage)
            tipPercentages.sort()
            FileManager.default.saveTipPercentages(tipPercentages)
            newTipPercentage = ""
        }
    }
    
    func removeTipPercentage(at offsets: IndexSet) {
        tipPercentages.remove(atOffsets: offsets)
        FileManager.default.saveTipPercentages(tipPercentages)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("Enter amount")) {
                        HStack {
                            TextField("Amount", text: $amount)
                                .keyboardType(.decimalPad)
                                .focused($amountIsFocused)
                            if !amount.isEmpty {
                                Button(action: {
                                    amount = ""
                                }) {
                                    Image(systemName: "xmark.circle.fill")
                                        .foregroundColor(.secondary)
                                }
                                .buttonStyle(BorderlessButtonStyle())
                            }
                        }
                    }
                    
                    Section(header: Text("Tip Calculation")) {
                        ForEach(tipPercentages, id: \.self) { tip in
                            HStack {
                                Text("\(tip)%")
                                Spacer()
                                let orderAmount = Double(amount) ?? 0
                                let tipAmount = calculateTipAmount(orderAmount: orderAmount, tipPercentage: tip)
                                let totalAmount = calculateTotalAmount(orderAmount: orderAmount, tipPercentage: tip)
                                VStack(alignment: .trailing) {
                                    Text("Tip: $\(tipAmount, specifier: "%.2f")")
                                    Text("Total: $\(totalAmount, specifier: "%.2f")")
                                }
                            }
                        }
                        .onDelete(perform: removeTipPercentage)
                    }
                    
                    Section(header: Text("Add Tip Percentage")) {
                        HStack {
                            TextField("New Tip Percentage", text: $newTipPercentage)
                                .keyboardType(.numberPad)
                                .focused($amountIsFocused)
                            Button(action: addTipPercentage) {
                                Image(systemName: "plus.circle.fill")
                                    .foregroundColor(.purple)
                            }
                        }
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                if amountIsFocused {
                    
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    VStack {
                        Text("Tip++")
                            .font(.title)
                    }
                }
                
                if !amountIsFocused {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        EditButton()
                        
                    }
                }
                
            }
            
        }
        
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
