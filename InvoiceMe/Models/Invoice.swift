//
//  Invoice.swift
//  InvoiceMe
//
//  Created by Rajan Maharjan on 31/10/2023.
//

import Foundation

public struct Invoice: Identifiable {
    public var id: String { number }
    let number: String
    let date: Date
    var lineItems: [InvoiceLine]
    
    public init(number: String = UUID().uuidString, date: Date = Date(), lineItems: [InvoiceLine] = []) {
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
    func mergeInvoices(sourceInvoice: Invoice) -> Invoice {
        var invoice = self
        sourceInvoice.lineItems.forEach {
            invoice.addLine(line: $0)
        }
        return invoice
    }
    
    /// Creates a deep clone of the current invoice (all fields and properties)
    func cloneInvoice() -> Invoice {
        let invoice = self
        return invoice
    }
    
    /// order the lineItems by Id - ascending and descending
    mutating func orderLineItems(ascending: Bool) {
        let sortedlineItems = lineItems.sorted {
            ascending ? $0.lineId < $1.lineId : $0.lineId > $1.lineId
        }
        lineItems.forEach { removeLine(lineId:  $0.lineId) }
        sortedlineItems.forEach { addLine(line: $0) }
    }
    
    /// returns the number of the line items specified in the variable `max`
    /// Implemented but not visible in Views
    func previewLineItems(_ max: Int) -> [InvoiceLine] {
        if max > lineItems.count { return [] }
        var items = [InvoiceLine]()
        
        for i in 0..<max {
            items.append(lineItems[i])
        }
        
        return items
    }
    
    /// remove the line items in the current invoice that are also in the sourceInvoice
    /// Implemented but not visible in Views
    mutating func removeItems(from sourceInvoice: Invoice) {
        let compareSet = Set(sourceInvoice.lineItems)
        let resultItems = lineItems.filter { !compareSet.contains($0) }
        lineItems = resultItems
    }
    
    /// Outputs string containing the following (replace [] with actual values):
    /// Invoice Number: [InvoiceNumber], InvoiceDate: [DD/MM/YYYY], LineItemCount: [Number of items in LineItems]
    func toString() -> String {
        return "Invoice Number: \(number), InvoiceDate: \(date.toString), LineItemCount: \(lineItems.count)"
    }
}

public struct InvoiceLine: Identifiable, Hashable {
    public var id: Int { lineId }
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

extension Date {
    var toString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/YYYY"
        return dateFormatter.string(from: self)
    }
}
