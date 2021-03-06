//
//  ContentView.swift
//  iExpense
//
//  Created by Michele Volpato on 14/12/2020.
//

import SwiftUI

struct ExpenseItem: Identifiable, Codable {
    let id: UUID
    let name: String
    let type: String
    let amount: Int

    init(id: UUID = UUID(), name: String, type: String, amount: Int) {
        self.id = id
        self.name = name
        self.type = type
        self.amount = amount
    }

}

class Expenses: ObservableObject {
    @Published var items: [ExpenseItem] {
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }

    init() {
        if let items = UserDefaults.standard.data(forKey: "Items") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([ExpenseItem].self, from: items) {
                self.items = decoded
                return
            }
        }

        self.items = []
    }
}

struct ContentView: View {
    @ObservedObject var expenses = Expenses()
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(expenses.items) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                        }

                        Spacer()
                        amountText(amount: item.amount)
                    }
                }
                .onDelete(perform: removeItems)
            }
            .navigationBarTitle("iExpense")
            .navigationBarItems(leading: EditButton(),
                                trailing:
                                    Button(action: {
                                        self.showingAddExpense = true
                                    }) {
                                        Image(systemName: "plus")
                                    }
            )
        }
        .sheet(isPresented: $showingAddExpense) {
            AddView(expenses: self.expenses)
        }
    }

    func amountText(amount: Int) -> some View {
        if amount < 10 {
            return Text("$\(amount)")
        }
        if amount < 100 {
            return Text("$\(amount)")
                .foregroundColor(.orange)
        }
        return Text("$\(amount)")
            .foregroundColor(.red)
    }

    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
