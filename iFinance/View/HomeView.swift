//
//  ContentView.swift
//  iFinance
//
//  Created by ALUNO on 04/05/22.
//

import SwiftUI

struct HomeView: View {
    @State var goToDashBoard = false
    @State var goToTransaction = false
    
    @State private var showingAlertSuccess = false
    @State private var showingAlertError = false
    
    @State var value = ""
    @State var accountIdx = 0
    @State var accountOptions = [
        "Inter", "Nubank", "Itau",
        "C6", "Next", "Caixa",
        "Bradesco", "Sicob", "Santander",
        "Banco do Brasil"
    ]
    @State var categoryIdx = 0
    @State var categoryOptions = [
        "Lazer", "Mercado", "Educação",
        "Roupas", "Saúde", "Transporte",
        "Viagens", "Cosméticos", "Casa"
    ]
    @State var description: String = ""
    
    var sqlite = SQLiteDatabase()
    
    func cleanFields() {
        self.value = ""
        self.description = ""
    }
    
    func includeIncome() {
        let result = sqlite.insertTransactionEntry(transactionEntry: TransactionEntry(
            value: Float64(self.value) ?? 0.0,
            account: self.accountOptions[accountIdx],
            category: self.categoryOptions[categoryIdx],
            description: self.description,
            flow: 1
        ))

        if result{
            self.showingAlertSuccess = true
        }else{
            self.showingAlertError = true
        }
        
        cleanFields()
    }
    
    func includeExpense() {
        let result = sqlite.insertTransactionEntry(transactionEntry: TransactionEntry(
            value: Float64(self.value) ?? 0.0,
            account: self.accountOptions[accountIdx],
            category: self.categoryOptions[categoryIdx],
            description: self.description,
            flow: 2
        ))
        
        if result{
            self.showingAlertSuccess = true
        }else{
            self.showingAlertError = true
        }
        
        cleanFields()
    }
    
    var body: some View {
        NavigationView {
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
                        TextField("R$28.99", text:$value)
                            .keyboardType(.decimalPad)
                    }
                    VStack(alignment: .leading, spacing: 2.0) {
                        Text("Conta").fontWeight(.bold)
                        HStack {
                            Picker(
                                selection: $accountIdx, label: Text("")
                            ) {
                                ForEach(0 ..< accountOptions.count) {
                                    Text(self.accountOptions[$0])
                                }
                            }
                            .accentColor(.blue)
                            .pickerStyle(.menu)
                            .padding(.horizontal, 45.0)
                        }
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(.gray, lineWidth: 1)
                        )
                    }
                    VStack(alignment: .leading, spacing: 2.0) {
                        Text("Categoria").fontWeight(.bold)
                        HStack {
                            Picker(
                                selection: $categoryIdx, label: Text("")
                            ) {
                                ForEach(0 ..< categoryOptions.count) {
                                    Text(self.categoryOptions[$0])
                                }
                            }
                            .accentColor(.blue)
                            .pickerStyle(.menu)
                            .padding(.horizontal, 45.0)
                        }
                        .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(.gray, lineWidth: 1)
                        )
                    }
                    VStack(alignment: .leading, spacing: 2.0) {
                        Text("Descrição").fontWeight(.bold)
                        TextField("Ingressos Dr. Estranho", text:$description)
                    }
                }
                    .textFieldStyle(.roundedBorder)
                    .padding(.all, 10.0)
                Spacer()
                HStack(alignment: .center, spacing: 50.0) {
                    Button {
                        goToTransaction = true
                    } label: {
                        Label("", systemImage: "list.dash")
                            .font(.largeTitle)
                    }
                    Menu {
                        Button("Saída", action: includeExpense)
                        Button("Entrada", action: includeIncome)
                    } label: {
                        Label("", systemImage: "square.and.arrow.up.fill")
                            .font(.largeTitle)
                    }
                    Button {
                        goToDashBoard = true
                    } label: {
                        Label("", systemImage: "chart.pie.fill")
                            .font(.largeTitle)
                    }
                }
                Spacer()
                NavigationLink(destination: DashboardView(), isActive: $goToDashBoard){
                }
                NavigationLink(destination: ListTransactionView(), isActive: $goToTransaction){
                }
            }
            .navigationBarTitle("")
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
        }
        .alert("Inserido com sucesso!", isPresented: $showingAlertSuccess) {
                    Button("OK", role: .cancel) { }
                }
        .alert("ERRO INESPERADO CONTATE O ADMINISTRADOR DO SISTEMA!!!!", isPresented: $showingAlertError) {
                    Button("OK", role: .cancel) { }
                }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
