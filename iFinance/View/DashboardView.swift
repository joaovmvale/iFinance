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
    
    var body: some View {
        let incomesList: [Double] = sqlite.getIncomeList()
        let expenseList: [Double] = sqlite.getExpenseList()
        
        let incomeSum = incomesList.reduce(0, +)
        let expenseSum = expenseList.reduce(0, +)
        let delta = incomeSum - expenseSum
        
        VStack (alignment:.center, spacing: 25.0){
            HStack{
                Image(systemName: "square.and.arrow.up.fill").font(.system(size: 25))
                    .foregroundColor(.green)
                Text("R$\(String(format: "%.2f", incomeSum))")
                Image(systemName: "square.and.arrow.down.fill").font(.system(size: 25))
                    .foregroundColor(.red)
                Text("R$\(String(format: "%.2f", expenseSum))")
            }
            
            HStack{
                Image(systemName: "dollarsign.circle.fill").font(.system(size: 25))
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
    }
}
struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
