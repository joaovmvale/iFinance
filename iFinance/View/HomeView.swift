//
//  ContentView.swift
//  iFinance
//
//  Created by ALUNO on 04/05/22.
//

import SwiftUI

struct HomeView: View {
    @State var value:String = ""
    @State private var selectedIdx = 0
    @State private var options = [
        "Inter", "Nubank", "Itau",
        "C6", "Next", "Caixa",
        "Bradesco", "Sicob", "Santander",
        "Banco do Brasil"
    ]
    
    func includeIncome() { }
    func includeExpense() { }
    
    var body: some View {
        VStack(alignment: .center) {
            VStack(alignment: .center, spacing: 10.0) {
                Text("iFin🍎nce")
                    .font(.largeTitle)
                    .bold()
                Text("Suas contas no controle")
                    .font(.subheadline)
            }
            Spacer()
            VStack(alignment: .leading, spacing: 30.0) {
                Text("Insira a sua movimentação aqui 💸")
                    .font(.subheadline)
                    .fontWeight(.ultraLight)
                    .padding(.bottom, -35.0)
                VStack(alignment: .leading, spacing: 2.0) {
                    Text("Valor").fontWeight(.bold)
                    TextField("R$58.99", text:$value)
                }
                VStack(alignment: .leading, spacing: 2.0) {
                    Text("Conta").fontWeight(.bold)
                    HStack {
                        Picker(
                            selection: $selectedIdx, label: Text("")
                        ) {
                            ForEach(0 ..< options.count) {
                                Text(self.options[$0])
                            }
                        }
                        .accentColor(.black)
                        .pickerStyle(.menu)
                    }
                    .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(.gray, lineWidth: 1) 
                    )
                }
                VStack(alignment: .leading, spacing: 2.0) {
                    Text("Categoria").fontWeight(.bold)
                    TextField("Lazer", text:$value)
                }
                VStack(alignment: .leading, spacing: 2.0) {
                    Text("Descrição").fontWeight(.bold)
                    TextField("Ingressos Dr. Estranho", text:$value)
                }
            }
                .textFieldStyle(.roundedBorder)
                .padding(.all, 10.0)
            Spacer()
            HStack(alignment: .center) {
                VStack {
                    Menu {
                        Button("Entrada", action: includeIncome)
                        Button("Gastos", action: includeExpense)
                    } label: {
                        Label("Incluir", systemImage: "square.and.arrow.up.fill")
                            .font(.title2)
                    }
                }
            }
            Spacer()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .previewInterfaceOrientation(.portrait)
    }
}
