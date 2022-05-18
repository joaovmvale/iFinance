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
                HStack(alignment: .center) {
                    Image(systemName: "arrow.up.arrow.down.square")
                        .font(.system(size: 25))
                        .foregroundColor(.blue)
                    Spacer()
                    Image(systemName: "tray.and.arrow.down.fill")
                        .font(.system(size: 25))
                        .foregroundColor(.blue)
                    Spacer()
                    Image(systemName: "pencil")
                        .font(.system(size: 25))
                        .foregroundColor(.blue)
                    Spacer()
                    Image(systemName: "text.aligncenter")
                        .font(.system(size: 25))
                        .foregroundColor(.blue)
                    Spacer()
                    Image(systemName: "dollarsign.circle.fill")
                        .font(.system(size: 25))
                        .foregroundColor(.blue)
                    Spacer()
                }
                    
                
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


struct ListTransactionView_Previews: PreviewProvider {
    static var previews: some View {
        ListTransactionView()
    }
}

struct ExtractedView: View {
    var value:Float64
    var account:String
    var category:String
    var description:String
    var flow:Int
    
    var body: some View {
        HStack(alignment: .center) {
            Text(flow == 1 ? "📈" : "📉")
            Spacer()
            Text(account)
            Spacer()
            Text(category)
            Spacer()
            Text(description)
                .frame(maxWidth: 50)
                .lineLimit(nil)
                .fixedSize()
            Spacer()
            Text("R$\(String(format: "%.2f", value))")
        }
            .font(.system(size: 10))
    }
}
