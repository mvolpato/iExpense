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

struct SecondView: View {
    @Environment(\.presentationMode) var presentationMode

    @State private var numbers = [Int]()
    @State private var currentNumber = 1

    var name: String

    var body: some View {
        NavigationView {
            VStack {
                Text("Hello, \(name)!")
                List {
                    ForEach(numbers, id: \.self) {
                        Text("\($0)")
                    }
                    .onDelete(perform: removeRows)
                }

                Button("Add Number") {
                    self.numbers.append(self.currentNumber)
                    self.currentNumber += 1
                }
                Button("Dismiss") {
                    self.presentationMode.wrappedValue.dismiss()
                }
            }
            .navigationBarItems(leading: EditButton())
        }
    }

    func removeRows(at offsets: IndexSet) {
        numbers.remove(atOffsets: offsets)
    }
}

struct ContentView: View {
    @ObservedObject private var user = User()
    @State private var showingSheet = false

    var body: some View {
        VStack {
            Text("Your name is \(user.firstName) \(user.lastName).")

            TextField("First name", text: $user.firstName)
            TextField("Last name", text: $user.lastName)
            Button("Show Sheet") {
                self.showingSheet.toggle()
            }
            .sheet(isPresented: $showingSheet) {
                SecondView(name: "@twostraws")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
