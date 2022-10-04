//
//  Trade.swift
//  Running Trade
//
//  Created by Fahri Novaldi on 04/10/22.
//

import Foundation

struct Trade {
    let stockID: String
    let price: Double
    let chg: Double
    let volume: Double
    let act: Action
    let time: String
    
    static func generateRandom() -> Trade {
        let alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        let id: String = "\(alphabet.randomElement()!)\(alphabet.randomElement()!)\(alphabet.randomElement()!)\(alphabet.randomElement()!)"
        
        let price: Double = Double.random(in: -2000...2000)
        let chg: Double = Double.random(in: -10...10)
        let volume: Double = Double.random(in: -2000...2000)
        let act: Action = Action.allCases.randomElement()!
        
        let time = Date.getTimeString()
        
        return Trade(stockID: id, price: price, chg: chg, volume: volume, act: act, time: time)
    }
}

enum Action: String, CaseIterable {
    case BU = "BU"
    case SD = "SD"
}
