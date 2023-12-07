//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Maks Winters on 07.12.2023.
//

import SwiftUI

struct ContentView: View {
    
    @State private var order = Order()
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    Picker("Select a type", selection: $order.type) {
                        ForEach(Order.types.indices, id: \.self) { index in
                            Text(Order.types[index])
                        }
                    }
                    Stepper("Number of cakes \(order.quantity)", value: $order.quantity, in: 3...20)
                }
                Section {
                    Toggle("Special requests", isOn: $order.isSpecialRequestEnabled)
                    if order.isSpecialRequestEnabled {
                        Toggle("Extra frosting", isOn: $order.extraFrosting)
                        Toggle("Add sprinkles", isOn: $order.addSprinkles)
                    }
                }
                Section {
                    NavigationLink("Delivery details") {
                        AdressView(order: order)
                    }
                }
            }
            .navigationTitle("Cupcake Corner")
        }
    }
}

#Preview {
    ContentView()
}
