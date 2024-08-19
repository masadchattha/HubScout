//
//  Date+Ext.swift
//  HubScout
//
//  Created by o9tech on 06/08/2024.
//

import Foundation

extension Date {

    func convertToMonthYearFormatUsingFormatter() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        return dateFormatter.string(from: self)
    }


    func convertToMonthYearFormat() -> String {
        return formatted(.dateTime.month().year())
    }
}
