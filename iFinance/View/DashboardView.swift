//
//  DashboardView.swift
//  iFinance
//
//  Created by ALUNO on 04/05/22.
//

import SwiftUI
import SwiftUICharts

struct DashboardView: View {
    @State var value:String = "R$4,.5678,23"
    var incomes: [Double] = [8, 2, 4, 6, 12, 9, 2]
    var outcomes: [Double] = [10, 5, 2, 6, 23, 3]
    var body: some View {
        VStack (alignment:.center, spacing: 25.0){
            HStack{
                Image(systemName: "square.and.arrow.up.fill").font(.system(size: 25))
                    .foregroundColor(.green)
                TextField("Entradas", text:$value)
                    Image(systemName: "square.and.arrow.down.fill").font(.system(size: 25))
                        .foregroundColor(.red)
                    TextField("Saídas", text:$value)
                
            }
            HStack{
                Image(systemName: "dollarsign.circle.fill").font(.system(size: 25))
                    .foregroundColor(.blue)
                TextField("Saídas", text:$value)
            }
            VStack(){
                Text("Entradas").multilineTextAlignment(.center)
                LineChart()
                       .data(incomes)
                       .chartStyle(ChartStyle(backgroundColor: .white,
                                              foregroundColor: ColorGradient(.green, .green)))
            }.overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.gray, lineWidth: 0.5)
            )
            VStack(){
                Text("Saídas").multilineTextAlignment(.center)
                LineChart()
                       .data(outcomes)
                       .chartStyle(ChartStyle(backgroundColor: .white
                                              ,
                                              foregroundColor: ColorGradient(.red, .red)))

            }.overlay(
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
