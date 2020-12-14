//
//  ContentView.swift
//  iExpense
//
//  Created by Michele Volpato on 14/12/2020.
//

import SwiftUI

class User: ObservableObject {
    @Published var firstName = "Bilbo"
    @Published var lastName = "Baggins"
}

struct ContentView: View {
    @ObservedObject private var user = User()
    @State private var showingSheet = false
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Your name is \(user.firstName) \(user.lastName).")
                
                TextField("First name", text: $user.firstName)
                TextField("Last name", text: $user.lastName)
                Button("Show Sheet") {
                    self.showingSheet.toggle()
                }
                NavigationLink(destination: StoreDataView()) {
                    Text("Check stored count")
                }
                .sheet(isPresented: $showingSheet) {
                    SecondView(name: "@twostraws")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
