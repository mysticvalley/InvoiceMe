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

extension InvoicesViewModel {
    func mergeInvoices() {
        print("\nMerging Invoices ...")
        var invoice1 = Invoice()
        
        invoice1.addLine(
            line: InvoiceLine(
                lineId: 1,
                description: "Banana",
                quantity: 4,
                cost: 10.33
            )
        )
        
        print("\tInvoice 1: \(invoice1.toString())")
        
        var invoice2 = Invoice()
        
        invoice2.addLine(
            line: InvoiceLine(
                lineId: 2,
                description: "Orange",
                quantity: 1,
                cost: 5.22
            )
        )
        
        invoice2.addLine(
            line: InvoiceLine(
                lineId: 3,
                description: "Blueberries",
                quantity: 3,
                cost: 6.27
            )
        )
        
        print("\tInvoice 2: \(invoice2.toString())")
        
        let mergedInvoice = invoice1.mergeInvoices(sourceInvoice: invoice2)
        print("MergedInvoice:")
        print("\tMerged Invoice: \(mergedInvoice.toString())")
        print("\tTotal: \(mergedInvoice.getTotal())")
        print("Lines:")
        
        mergedInvoice.lineItems.forEach {
            print("\tLineId: \($0.lineId)")
            print("\tDescription: \($0.description)")
            print("\tQty: \($0.quantity)")
            print("\tCost: \($0.cost)")
        }
    }
    
    func cloneInvoice() {
        print("\nCloning Invoice ...")
                
        var invoice = Invoice()
        
        invoice.addLine(
            line: InvoiceLine(
                lineId: 1,
                description: "Apple",
                quantity: 1,
                cost: 6.99
            )
        )
        
        invoice.addLine(
            line: InvoiceLine(
                lineId: 2,
                description: "Blueberries",
                quantity: 3,
                cost: 6.27
            )
        )
        
        print("\tSource Invoice : \(invoice.toString())")
        
        let clonedInvoice = invoice.cloneInvoice()
        print("Cloned Invoice:")
        print("\tTotal: \(clonedInvoice.getTotal())")
        print("Lines:")
        
        clonedInvoice.lineItems.forEach {
            print("\tLineId: \($0.lineId)")
            print("\tDescription: \($0.description)")
            print("\tQty: \($0.quantity)")
            print("\tCost: \($0.cost)")
        }
    }
    
    func previewLineItems() {
        var invoice = Invoice()
        
        invoice.addLine(
            line: InvoiceLine(
                lineId: 1,
                description: "Banana",
                quantity: 4,
                cost: 10.21
            )
        )
        
        invoice.addLine(
            line: InvoiceLine(
                lineId: 2,
                description: "Orange",
                quantity: 1,
                cost: 5.21
            )
        )
        
        invoice.addLine(
            line: InvoiceLine(
                lineId: 3,
                description: "Pizza",
                quantity: 5,
                cost: 5.21
            )
        )
        
        print("\tSource Invoice : \(invoice.toString())")
        
        let items = invoice.previewLineItems(2)
        
        print("\nPreview Inline Items:")
        
        items.forEach {
            print("\tLineId: \($0.lineId)")
            print("\tDescription: \($0.description)")
            print("\tQty: \($0.quantity)")
            print("\tCost: \($0.cost)")
        }
    }
}
