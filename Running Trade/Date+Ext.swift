//
//  Date+Ext.swift
//  Running Trade
//
//  Created by Fahri Novaldi on 04/10/22.
//

import Foundation

extension Date {
    
    static func getTimeString() -> String {
        let today = Date()
        
        let hours   = (Calendar.current.component(.hour, from: today))
        let minutes = (Calendar.current.component(.minute, from: today))
        let seconds = (Calendar.current.component(.second, from: today))
        
        return "\(hours):\(minutes):\(seconds)"
    }
}
