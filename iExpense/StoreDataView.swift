//
//  StoreDataView.swift
//  iExpense
//
//  Created by Michele Volpato on 14/12/2020.
//

import SwiftUI

struct StoreDataView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var tapCount = UserDefaults.standard.integer(forKey: "Tap")

    var body: some View {
        Button("Tap count: \(tapCount)") {
            self.tapCount += 1
            UserDefaults.standard.set(self.tapCount, forKey: "Tap")
        }
    }
}

struct StoreDataView_Previews: PreviewProvider {
    static var previews: some View {
        StoreDataView()
    }
}
