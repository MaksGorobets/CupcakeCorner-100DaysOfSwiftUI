//
//  AdressView.swift
//  CupcakeCorner
//
//  Created by Maks Winters on 07.12.2023.
//

import SwiftUI

struct AdressView: View {
    
    @Bindable var order: Order
    
    var body: some View {
        List {
            Section("Enter your address") {
                TextField("Enter your name", text: $order.name)
                TextField("Enter your street address", text: $order.streetAddress)
                TextField("Enter your city", text: $order.city)
                TextField("Enter your zip code", text: $order.zip)
            }
            Section {
                NavigationLink("Check out") {
                    CheckoutView(order: order)
                }
                .disabled(order.isAdressValid == false)
            }
        }
        .navigationTitle("Delivery details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    AdressView(order: Order())
}
