//
//  RateCollectionViewCell.swift
//  Exchange
//
//  Created by Maxim Bekmetov on 30.10.2021.
//

import UIKit

class RateCollectionViewCell: UICollectionViewCell {
    
    static var reusedID = "RateCollectionViewCell"
    
    @IBOutlet weak var tpLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var fromLabel: UILabel!
    @IBOutlet weak var currMnemFromLabel: UILabel!
    @IBOutlet weak var toLabel: UILabel!
    @IBOutlet weak var currMnemToLabel: UILabel!
    @IBOutlet weak var basicLabel: UILabel!
    @IBOutlet weak var buyLabel: UILabel!
    @IBOutlet weak var saleLabel: UILabel!
    @IBOutlet weak var deltaBuyLabel: UILabel!
    @IBOutlet weak var deltaSaleLabel: UILabel!
    
    func configure(tp: Int, name: String, from: Int, currMnemFrom: String, to: Int, currMnemTo: String, basic: String, buy: String, sale: String, deltaBuy: String, deltaSale: String) {
        
        tpLabel.text = "tp : " + String(tp)
        nameLabel.text = "name : " + name
        fromLabel.text = "from : " + String(from)
        currMnemFromLabel.text = "currMnemFrom : " + currMnemFrom
        toLabel.text = "to : " + String(to)
        currMnemToLabel.text = "currMnemTo : " + currMnemTo
        basicLabel.text = "basic : " + basic
        buyLabel.text = "buy : " + buy
        saleLabel.text = "sale : " + sale
        deltaBuyLabel.text = "deltaBuy : " + deltaBuy
        deltaSaleLabel.text = "deltaSale : " + deltaSale
    }
}
