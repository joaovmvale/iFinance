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
    var demoData: [Double] = [8, 2, 4, 6, 12, 9, 2]
    var body: some View {
        VStack (alignment:.center, spacing: 25.0){
            Text("Dashboard")
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            HStack{
                VStack{
                    Text("Entradas")
                    TextField("Entradas", text:$value)
                    
                }
                VStack{
                    Text("Saídas")
                    TextField("Saídas", text:$value)
                }
                VStack{
                    Text("Saldo")
                    TextField("Saídas", text:$value)
                }
            }
            VStack{
                LineChart()
                       .data(demoData)
                       .chartStyle(ChartStyle(backgroundColor: .white,
                                              foregroundColor: ColorGradient(.green, .green)))
            }
            VStack{
                LineChart()
                       .data(demoData)
                       .chartStyle(ChartStyle(backgroundColor: .white,
                                              foregroundColor: ColorGradient(.red, .red)))
            }
        }.padding(.all, 10).textFieldStyle(.roundedBorder)
       Spacer()
    }
}
struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
