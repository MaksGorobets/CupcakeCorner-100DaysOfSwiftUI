//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Maks Winters on 09.12.2023.
//

import SwiftUI

struct CheckoutView: View {
    
    var order: Order
    
    @State private var confirmationMessage = ""
    @State private var showingCheck = false
    @State private var showingConfirmation = false
    @State private var returnedOrder = Order()
    
    var body: some View {
        ZStack {
            VStack {
                ScrollView {
                    VStack {
                        AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
                            image
                                .resizable()
                                .scaledToFit()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(height: 233)
                        Text("Your total is: \(order.total, format: .currency(code: "USD"))")
                            .font(.title)
                        if showingCheck {
                            CheckView(order: returnedOrder)
                        }
                    }
                }
            }
            VStack {
                Spacer()
                Button("Place order") {
                    Task {
                        guard let order = await placeOrder() else { return }
                        returnedOrder = order
                    }
                }
                    .buttonStyle(.borderedProminent)
                    .tint(.green)
                    .clipShape(RoundedRectangle(cornerRadius: 25.0))
                    .shadow(radius: 5)
            }
        }
        .alert("Thank you", isPresented: $showingConfirmation) {
            Button("OK") {}
        } message: {
            Text(confirmationMessage)
        }
//        .scrollBounceBehavior(.basedOnSize)
        .navigationTitle("Check out")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func placeOrder() async -> Order? {
        
        guard let encoded = try? JSONEncoder().encode(order) else {
            print("Failed to encode order.")
            return nil
        }
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            print("Data edcoded and uploaded")
            
            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            print("Data downloaded and decoded")
            
            confirmationMessage = "Your order for \(Order.types[decodedOrder.type]) x\(decodedOrder.quantity) is placed! You may see the details on the check."
            
            showingConfirmation = true
            showingCheck = true
            return decodedOrder
        } catch {
            print("Upload failed \(error)")
        }
        return nil
    }
    
}
struct CheckView: View {
    
    var order: Order
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .foregroundStyle(.yellow)
            .frame(height: 400)
            .containerRelativeFrame(.horizontal) { width, Axis in
                width * 0.7
            }
            .overlay {
                VStack {
                    Text("Order details")
                        .font(.title2)
                    Text("If you see this receipt - your order is placed!")
                    Spacer()
                    VStack(alignment: .leading) {
                        Text("Ordered type: \(Order.types[order.type])")
                        Text("Quantity: \(order.quantity)")
                        Text("Extra frosted: \(String(order.extraFrosting))")
                        Text("With sprinkles: \(String(order.addSprinkles))")
                    }
                    Spacer()
                    Text("Total: \(order.total, format: .currency(code: "USD"))")
                        .font(.title2)
                }
                .foregroundStyle(.black)
                .padding()
            }
            .shadow(radius: 5)
    }
}

#Preview {
    CheckoutView(order: Order())
}
