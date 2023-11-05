//
//  Invoice+Mocks.swift
//  InvoiceMe
//
//  Created by Rajan Maharjan on 31/10/2023.
//

import Foundation

public extension Invoice {
    static var mockSingleItem: Invoice {
        .init(
            number: "some-uuid-1",
            date: .mock,
            lineItems: [
                .mockOne
            ]
        )
    }
    
    static var mockMultipleItem: Invoice {
        .init(
            number: "some-uuid-2",
            date: .mock,
            lineItems: [
                .mockOne, .mockTwo, .mockThree
            ]
        )
    }
}

public extension InvoiceLine {
    static var mockOne: InvoiceLine {
        .init(
            lineId: 1,
            description: "line 1",
            quantity: 10,
            cost: 50.2
        )
    }
    
    static var mockTwo: InvoiceLine {
        .init(
            lineId: 2,
            description: "line 2",
            quantity: 15,
            cost: 35.8
        )
    }
    
    static var mockThree: InvoiceLine {
        .init(
            lineId: 3,
            description: "line 3",
            quantity: 23,
            cost: 23.3
        )
    }
}

public extension Date {
    static var mock: Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/YYYY"
        return dateFormatter.date(from: "10/10/2023")!
    }
}
