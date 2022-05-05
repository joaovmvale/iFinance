//
//  ContentView.swift
//  iFinance
//
//  Created by ALUNO on 04/05/22.
//

import SwiftUI

struct HomeView: View {
    @State var value:String = ""
    
    var body: some View {
        VStack(alignment: .center) {
            Text("iFin🍎nce")
                .font(.largeTitle)
            Text("Suas contas no controle")
                .font(.subheadline)
            Spacer()
            VStack(alignment: .leading) {
                Text("Valor").padding(.vertical, -15.0)
                TextField("R$58.99", text:$value)
            }
        }.padding(.all, 4.0)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
