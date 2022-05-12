import SwiftUI

struct ListTransationView: View {
    var body: some View {
        VStack{
            List{
                HStack{
                    Text("📈")
                    Spacer()
                    Text("Descrição")
                    Spacer()
                    Text("R$")
                    Spacer()
                }
                //ForEach(viewModel.amount.indices, id:\.self){i in
                //    ExtractedView(id: i, description: viewModel.amount[i].description, amount: viewModel.amount[i].amount)
               // }
            }
        }
        .navigationBarTitle("Transações Financeiras", displayMode: .inline)
    }
}


struct ListTransationView_Previews: PreviewProvider {
    static var previews: some View {
        ListTransationView()
    }
}

struct ExtractedView: View {
    var id:Int = 0
    var description:String = ""
    var amount:Int = 0
    var body: some View {
        HStack{
            Text(String(id))
            Spacer()
            Text(description)
            Spacer()
            Text(String(amount))
        }
    }
}
