//
//  InvoicesViewModel.swift
//  InvoiceMe
//
//  Created by Rajan Maharjan on 31/10/2023.
//

import Foundation

final class InvoicesViewModel: ObservableObject {
    @Published var invoices: [Invoice] = []
    private var lineItemCounter = 1
    
    init(invoices: [Invoice] = []) {
        self.invoices = invoices
    }
    
    func deleteLineItems(at offsets: IndexSet, section: Int) {
        var invoice = invoices[section]
        
        offsets.forEach { index in
            invoice.lineItems.remove(at:  index)
        }
        
        invoices.remove(at: section)
        invoices.insert(invoice, at: section)
    }
    
    func createInvoiceSingleItemInvoice() {
        var invoice = Invoice()
        invoice.addLine(line: InvoiceLine(
            lineId: lineItemCounter,
            description: "Pizza \(lineItemCounter)",
            quantity: 10,
            cost: 10.3
        ))
        
        lineItemCounter += 1
        
        invoices.append(invoice)
    }
    
    func createInvoiceMultipleItemsInvoice() {
        var invoice = Invoice()
        
        invoice.addLine(line: InvoiceLine(
            lineId: lineItemCounter,
            description: "Banana \(lineItemCounter)",
            quantity: 4,
            cost: 10.3
        ))
        
        lineItemCounter += 1
        
        invoice.addLine(line: InvoiceLine(
            lineId: lineItemCounter,
            description: "Orange \(lineItemCounter)",
            quantity: 1,
            cost: 5.21
        ))
        
        lineItemCounter += 1
        
        invoice.addLine(line: InvoiceLine(
            lineId: lineItemCounter,
            description: "Pizza \(lineItemCounter)",
            quantity: 10,
            cost: 10.3
        ))
        
        lineItemCounter += 1
        
        invoices.append(invoice)
    }
    
    func sortLineItems(ascending: Bool) {
        var newInvoices = [Invoice]()
        
        invoices.forEach { inv in
            var invoice = inv
            invoice.orderLineItems(ascending: ascending)
            newInvoices.append(invoice)
        }
        
        invoices = newInvoices
    }
}
