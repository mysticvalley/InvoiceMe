//
//  ContentView.swift
//  InvoiceMe
//
//  Created by Rajan Maharjan on 31/10/2023.
//

import SwiftUI

struct InvoicesView: View {
    @ObservedObject var viewModel: InvoicesViewModel
    
    var body: some View {
        NavigationStack {
            content
                .navigationTitle("InvoiceMe")
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        HStack {
                            Spacer()
                            Button {
                                viewModel.createInvoiceMultipleItemsInvoice()
                            } label: {
                                Image(systemName: "doc.on.doc")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 24, height: 24)
                            }
                            Button {
                                viewModel.createInvoiceSingleItemInvoice()
                            } label: {
                                Image(systemName: "doc")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 24, height: 24)
                            }
                        }
                    }
                    
                }
        }
    }
    
    @ViewBuilder
    var content: some View {
        if viewModel.invoices.isEmpty {
            Text("Create invoice from top right button!")
        } else {
            List {
                ForEach(viewModel.invoices, id: \.number) { inv in
                    Section(
                        content: {
                            // Shows line item information
                            ForEach(inv.lineItems, id: \.lineId) { line in
                                VStack(alignment: .leading) {
                                    Text("LineId: \t\t\t\t\(line.lineId)")
                                        .padding(.vertical, 5)
                                    Text("Description: \t\t \(line.description)")
                                        .padding(.vertical, 5)
                                    Text("Quantity: \t\t\t\(line.quantity)")
                                        .padding(.vertical, 5)
                                    Text("Cost: \t\t\t\t\(String(format: "%.2f", line.cost))")
                                        .padding(.vertical, 5)
                                }
                            }
                        },
                        header: {
                            // Shows the invoice information
                            HStack {
                                Text("Invoice \(inv.number)")
                                Spacer()
                                Text("Date: \(inv.date.description)")
                            }
                        }
                    )
                }
            }
            .listStyle(.grouped)
        }
    }
}

struct InvoicesView_Previews: PreviewProvider {
    static var previews: some View {
        InvoicesView(viewModel: .init(
            invoices: [.mockSingleItem, .mockMultipleItem]
        ))
    }
}
