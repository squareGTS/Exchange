//
//  CurrencyData.swift
//  Exchange
//
//  Created by Maxim Bekmetov on 29.10.2021.
//

import Foundation

struct CurrencyData: Codable {
    var code: Int
    var messageTitle: String
    var message: String
    var rid: String
    var downloadDate: String
    var rates: [Rates]
    var productState: Int
    var ratesDate: String
}

struct Rates: Codable {
    var tp : Int
    var name: String
    var from: Int
    var currMnemFrom: String
    var to: Int
    var currMnemTo: String
    var basic: String
    var buy: String
    var sale: String
    var deltaBuy: String
    var deltaSale: String
}
