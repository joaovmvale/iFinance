import SwiftUI

struct ListTransactionView: View {
    var sqlite = SQLiteDatabase()
    
    @State private var showingAlertError = false
    
    func getTransactionEntries() -> [TransactionEntry] {
        let result = sqlite.getTransactionsEntries()
        
        if result.isEmpty {
            self.showingAlertError = true
            return []
        }
        
        return result
    }
    
    var body: some View {
        VStack{
            List{
                let transactions: [TransactionEntry] = getTransactionEntries()
                
                ForEach(transactions.indices, id: \.self){
                    i in
                    ExtractedView(
                        value: transactions[i].value,
                        account: transactions[i].account,
                        category: transactions[i].category,
                        description: transactions[i].description,
                        flow: transactions[i].flow
                    )
                }
            }
        }
            .navigationBarTitle("Transações Financeiras", displayMode: .inline)
            .alert(
                "ERRO INESPERADO CONTATE O ADMINISTRADOR DO SISTEMA!!!!",
                isPresented: $showingAlertError) {
                        Button("OK", role: .cancel) { }
                    }
    }
}

struct ExtractedView: View {
    var value:Float64
    var account:String
    var category:String
    var description:String
    var flow:Int
    
    var body: some View {
        VStack(alignment: .center) {
            HStack(alignment: .center) {
                Text(flow == 1 ? "📈" : "📉")
                    .frame(width: 15.0, height: 20.00, alignment: .center)
                    .fixedSize()
                Spacer()
                Text(account)
                    .frame(width: 60.0, height: 20.00, alignment: .leading)
                    .fixedSize()
                Spacer()
                Text(category)
                    .frame(width: 60.0, height: 20.00, alignment: .center)
                    .fixedSize()
                Spacer()
                Text(
                    flow == 1
                     ? "R$ \(String(format: "%.2f", value))"
                     : "- R$ \(String(format: "%.2f", value))"
                )
                    .frame(width: 90.0, height: 20.00, alignment: .trailing)
                    .fixedSize()
            }
            
            HStack {
                Text(description)
                    .fontWeight(.bold)
                    .frame(width: 225.0, height: 30.00, alignment: .center)
                    .fixedSize()
            }
        }
            .font(.system(size: 10))
    }
}

struct ListTransactionView_Previews: PreviewProvider {
    static var previews: some View {
        ListTransactionView()
    }
}
