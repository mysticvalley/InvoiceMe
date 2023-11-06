#  Introduction

This is a project prepared by Rajan Maharjan (rmjn.mdev@gmail.com) for Xero Pty Ltd as a technical assessment for the role of Senior iOS engineer.

# Getting started

The project is built using Xcode 14.3.1, with minium deployment target of iOS 16.4 and it uses SwiftUI technology for building views.

To run the project, please follow the following steps

1. Open [InvoiceMe.xcodeproj](InvoiceMe/InvoiceMe.xcodeproj) within Xcode 14.3.1 or later 
2. Build the run the project

# Dependencies

The project doesn't use any dependency manager to manage external libraries.

# Documentation 

The developer documentation for the project is inside the Documentation directory. This project uses [ADRs](https://adr.github.io) to record a log of decisions, importantly explaining the "Why?" behind these decisions. 

# Unit test

The Unit test are written for some of the business logics in the `ViewModel`. To run the unit test

1. Open [InvoiceMe.xcodeproj](InvoiceMe/InvoiceMe.xcodeproj) within Xcode 14.3.1 or later 
2. Press Command + U from keyboard
3. Alernatively you can go to Product > Test from Product menu. 
 
# About the assessment solution

The project uses SwiftUI technology to render the Views. I have used simple views to demonstrate following invoice operations:

1. Invoice Creation operations with single line item.
2. Invoice Creation operations with multiple line items.
3. Ascending and decending sort operation on existing Invoice line items

Following operations are not demonstrated in the UI but only in the xcode console.

1. Merge invoices
2. Clone invoice
3. Preview line items
