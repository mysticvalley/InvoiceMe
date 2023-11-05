//
//  ContentView.swift
//  InvoiceMe
//
//  Created by Rajan Maharjan on 31/10/2023.
//

import SwiftUI

struct InvoicesView: View {
    @ObservedObject var viewModel: InvoicesViewModel
    @Environment(\.editMode) var editMode
    
    var body: some View {
        NavigationStack {
            content
                .navigationTitle("InvoiceMe")
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        EditButton()
                    }
                    
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
                ForEach(Array(zip(viewModel.invoices.indices, viewModel.invoices)), id: \.0) { index, inv in
                    Section(
                        content: {
                            // Shows line item information
                            ForEach(inv.lineItems, id: \.lineId) { line in
                                InvoiceLineView(line: line)
                            }
                            .onDelete { indexSet in
                                viewModel.deleteLineItems(at: indexSet, section: index)
                            }
                        },
                        header: {
                            // Shows the invoice information
                            InvoiceHeaderView(invoice: inv)
                        }
                    )
                }
            }
            .listStyle(.grouped)
        }
    }
}

struct InvoiceHeaderView: View {
    let invoice: Invoice
    
    var body: some View {
        HStack {
            Text("Invoice \(invoice.number)")
            Spacer()
            Text("Date: \(invoice.date.description)")
        }
    }
}

struct InvoiceLineView: View {
    let line: InvoiceLine
    
    var body: some View {
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
}

struct InvoicesView_Previews: PreviewProvider {
    static var previews: some View {
        InvoicesView(viewModel: .init(
            invoices: [.mockSingleItem, .mockMultipleItem]
        ))
    }
}
