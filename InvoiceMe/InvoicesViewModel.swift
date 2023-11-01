//
//  InvoicesViewModel.swift
//  InvoiceMe
//
//  Created by Rajan Maharjan on 31/10/2023.
//

import Foundation

final class InvoicesViewModel: ObservableObject {
    @Published var invoices: [Invoice] = []
    private var invoiceCounter = 1
    private var lineItemCounter = 1
    
    init(invoices: [Invoice] = []) {
        self.invoices = invoices
    }
    
    
    func createInvoiceSingleItemInvoice() {
        var invoice = Invoice(number: invoiceCounter, date: Date())
        invoice.addLine(line: InvoiceLine(
            lineId: lineItemCounter,
            description: "Pizza \(lineItemCounter)",
            quantity: 10,
            cost: 10.3
        ))
        
        lineItemCounter += 1
        
        invoices.append(invoice)
        invoiceCounter += 1
    }
    
    func createInvoiceMultipleItemsInvoice() {
        var invoice = Invoice(number: invoiceCounter, date: Date())
        
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
        invoiceCounter += 1
    }        
}
