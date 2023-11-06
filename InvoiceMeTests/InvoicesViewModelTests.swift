//
//  InvoiceMeTests.swift
//  InvoiceMeTests
//
//  Created by Rajan Maharjan on 31/10/2023.
//

import XCTest
@testable import InvoiceMe

final class InvoicesViewModelTests: XCTestCase {
    var viewModel: InvoicesViewModel!
    var mockInvoices: [Invoice] = []
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        mockInvoices = [.mockSingleItem]
        viewModel = InvoicesViewModel(invoices: mockInvoices)
    }
    
    func testInvoicesInit() {
        XCTAssertFalse(viewModel.invoices.isEmpty)
    }
    
    func testInvoiceDeleteLineItems() {
        // Given
        viewModel = InvoicesViewModel(invoices: [.mockSingleItem, .mockMultipleItem])
        let indexSet = IndexSet([0, 1])
        
        // When
        viewModel.deleteLineItems(at: indexSet, section: 1)
        
        // Then
        let invoice = viewModel.invoices[1]
        
        XCTAssertEqual(invoice.number, Invoice.mockMultipleItem.number)
        XCTAssertEqual(invoice.lineItems.count, 1)
        invoice.lineItems.forEach {
            XCTAssertEqual($0, .mockTwo)
        }
    }
    
    func testCreateInvoiceWithSingleItem() {
        // Given
        viewModel = InvoicesViewModel()
        let expectedLine = InvoiceLine(
            lineId: 1,
            description: "Pizza 1",
            quantity: 10,
            cost: 10.3
        )
        
        // When
        viewModel.createInvoiceSingleItemInvoice()
        
        // Then
        XCTAssertFalse(viewModel.invoices.isEmpty)
        XCTAssertEqual(viewModel.invoices.count, 1)
        
        if let invoice = viewModel.invoices.first {
            XCTAssertEqual(invoice.lineItems.count, 1)
            invoice.lineItems.forEach {
                XCTAssertEqual($0, expectedLine)
            }
        }
    }
    
    func testCreateInvoiceWithMultipleItems() {
        // Given
        viewModel = InvoicesViewModel()
        let expectedLines = [
            InvoiceLine(
                lineId: 1,
                description: "Banana 1",
                quantity: 4,
                cost: 10.3
            ),
            InvoiceLine(
                lineId: 2,
                description: "Orange 2",
                quantity: 1,
                cost: 5.21
            ),
            InvoiceLine(
                lineId: 3,
                description: "Pizza 3",
                quantity: 10,
                cost: 10.3
            )
        ]
        
        // When
        viewModel.createInvoiceMultipleItemsInvoice()
        
        // Then
        XCTAssertFalse(viewModel.invoices.isEmpty)
        XCTAssertEqual(viewModel.invoices.count, 1)
        
        if let invoice = viewModel.invoices.first {
            let lineItems = invoice.lineItems
            
            XCTAssertEqual(lineItems.count, 3)
            for i in 0..<expectedLines.count {
                XCTAssertEqual(lineItems[i], expectedLines[i])
            }
        }
    }
}
