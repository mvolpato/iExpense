//
//  CodableData.swift
//  iExpense
//
//  Created by Michele Volpato on 14/12/2020.
//

import SwiftUI

struct CodableUser: Codable {
    var firstName: String
    var lastName: String
}

struct CodableData: View {
    @State private var user = CodableUser(firstName: "Taylor", lastName: "Swift")

    var body: some View {
        Button("Save User") {
            let encoder = JSONEncoder()

            if let data = try? encoder.encode(self.user) {
                UserDefaults.standard.set(data, forKey: "UserData")
            }
        }
    }
}

struct CodableData_Previews: PreviewProvider {
    static var previews: some View {
        CodableData()
    }
}
