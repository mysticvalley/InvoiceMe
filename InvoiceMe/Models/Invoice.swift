//
//  Invoice.swift
//  InvoiceMe
//
//  Created by Rajan Maharjan on 31/10/2023.
//

import Foundation

public struct Invoice: Identifiable {
    public var id: Int { number }
    let number: Int
    let date: Date
    var lineItems: [InvoiceLine]
    
    public init(number: Int, date: Date, lineItems: [InvoiceLine] = []) {
        self.number = number
        self.date = date
        self.lineItems = lineItems
    }
    
    mutating func addLine(line: InvoiceLine) {
        lineItems.append(line)
    }
    
    mutating func removeLine(lineId: Int) {
        guard let itemToRemoveIndex = lineItems.firstIndex(where: { $0.lineId == lineId }) else {
            print("line item not found with lineId")
            return
        }
        
        let removedItem = lineItems.remove(at: itemToRemoveIndex)
        print("Removed item from line: \(removedItem)")
    }
    
    /// GetTotal should return the sum of (Cost * Quantity) for each line item
    func getTotal() -> Double {
                
        let total = lineItems.reduce(0) { partialResult, line in
            return partialResult + line.cost * Double(line.quantity)
        }
        
        return total
    }
}

extension Invoice {
    /// MergeInvoices appends the items from the sourceInvoice to the current invoice
    func mergeInvoice(sourceInvoice: Invoice) -> Invoice {
        .init(number: 30, date: Date())
    }
    
    /// Creates a deep clone of the current invoice (all fields and properties)
    func cloneInvoice() -> Invoice {
        .init(number: 20, date: Date())
    }
    
    /// order the lineItems by Id
    func orderLineItems() {
        fatalError("not implemented")
    }
    
    /// returns the number of the line items specified in the variable `max`
    func previewLineItems(_ max: Int) -> [InvoiceLine] {
        fatalError("not implemented")
    }
    
    /// remove the line items in the current invoice that are also in the sourceInvoice
    func removeItems(from sourceInvoice: Invoice) {
        fatalError("not implemented")
    }
    
    /// Outputs string containing the following (replace [] with actual values):
    /// Invoice Number: [InvoiceNumber], InvoiceDate: [DD/MM/YYYY], LineItemCount: [Number of items in LineItems]
    func toString() -> String {
        fatalError("not implemented")
    }
}

public struct InvoiceLine {
    let lineId: Int
    let description: String
    let quantity: Int
    let cost: Double
    
    public init(lineId: Int, description: String, quantity: Int, cost: Double) {
        self.lineId = lineId
        self.description = description
        self.quantity = quantity
        self.cost = cost
    }
}
