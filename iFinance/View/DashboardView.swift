//
//  DashboardView.swift
//  iFinance
//
//  Created by ALUNO on 04/05/22.
//

import SwiftUI
import SwiftUICharts

struct DashboardView: View {
    var sqlite = SQLiteDatabase()
    
    let incomesList: [Double]
    let expenseList: [Double]
    
    @State private var showingEmptyListWarning = false
    
    init(){
        incomesList = sqlite.getIncomeList()
        expenseList = sqlite.getExpenseList()
        
        if (!hasMultipleValues(_list: incomesList) || !hasMultipleValues(_list: expenseList)) {
            showingEmptyListWarning = true
        }
    }
    
    func hasMultipleValues(_list: [Double]) -> Bool {
        if (_list.count == 1) {
            return false
        }
        
        return true
    }
    
    var body: some View {
        let incomeSum = incomesList.reduce(0, +)
        let expenseSum = expenseList.reduce(0, +)
        let delta = incomeSum - expenseSum
        
        
        
        VStack (alignment:.center, spacing: 25.0){
            HStack{
                Image(systemName: "square.and.arrow.up.fill").font(.system(size: 16))
                    .foregroundColor(.green)
                Text("R$\(String(format: "%.2f", incomeSum))")
                Image(systemName: "square.and.arrow.down.fill").font(.system(size: 16))
                    .foregroundColor(.red)
                Text("R$\(String(format: "%.2f", expenseSum))")
            }
            
            HStack{
                Image(systemName: "dollarsign.circle.fill").font(.system(size: 16))
                    .foregroundColor(.blue)
                Text("R$\(String(format: "%.2f", delta))")
            }
            
            VStack(){
                Text("Entradas").multilineTextAlignment(.center)
                LineChart()
                       .data(incomesList)
                       .chartStyle(
                            ChartStyle(
                                backgroundColor: .white,
                                foregroundColor: ColorGradient(.green, .green)
                            )
                       )
            }
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.gray, lineWidth: 0.5)
            )
            
            VStack(){
                Text("Saídas").multilineTextAlignment(.center)
                LineChart()
                       .data(expenseList)
                       .chartStyle(
                            ChartStyle(
                                backgroundColor: .white,
                                foregroundColor: ColorGradient(.red, .red)
                            )
                       )
            }
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.gray, lineWidth: 0.5)
            )
        }
        .padding([.leading, .bottom, .trailing], 20)
        .textFieldStyle(.roundedBorder)
        .navigationBarTitle("Dashboard", displayMode: .inline)
        .alert("Insira mais transações para popular os gráficos.", isPresented: $showingEmptyListWarning) {
                    Button("OK", role: .cancel) { }
                }
    }
}
struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
