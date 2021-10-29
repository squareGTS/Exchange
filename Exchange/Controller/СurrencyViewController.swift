//
//  ViewController.swift
//  Exchange
//
//  Created by Maxim Bekmetov on 29.10.2021.
//

import UIKit

class СurrencyViewController: UIViewController {
    
    @IBOutlet weak var codeLabel: UILabel!
    @IBOutlet weak var messageTitleLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var ridLabel: UILabel!
    @IBOutlet weak var downloadDateLabel: UILabel!
    @IBOutlet weak var productStateLabel: UILabel!
    @IBOutlet weak var ratesDateLabel: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var networkingService = NetworkingService()
    
    var rates: [Rates] = []
    
    var width = 1
    var height = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        networkingService.delegate = self
        
        networkingService.getRequest()
    }
    
}

//MARK: - NetworkingServiceDelegate
extension СurrencyViewController: NetworkingServiceDelegate {
    
    func didUpdateCurrency(_ networkingService: NetworkingService, currency: CurrencyData) {
        DispatchQueue.main.async {
            
            self.codeLabel.text = "code : " + String(currency.code)
            self.messageTitleLabel.text = "messageTitle : " + currency.messageTitle
            self.messageLabel.text = "message : " + currency.message
            self.ridLabel.text = "rid : " + currency.rid
            self.downloadDateLabel.text = "downloadDate : " + currency.downloadDate
            self.productStateLabel.text = "productState : " + String(currency.productState)
            self.ratesDateLabel.text = "ratesDate : " + currency.ratesDate
            
            self.rates = currency.rates
            
            self.collectionView.reloadData()
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
}

//MARK: - UICollectionViewDataSource, UICollectionViewDelegate
extension СurrencyViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(rates.count)
        return rates.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RateCollectionViewCell.reusedID, for: indexPath) as! RateCollectionViewCell
        
        cell.configure(
            tp: rates[indexPath.row].tp,
            name: rates[indexPath.row].name,
            from: rates[indexPath.row].from,
            currMnemFrom: rates[indexPath.row].currMnemFrom,
            to: rates[indexPath.row].to,
            currMnemTo: rates[indexPath.row].currMnemTo,
            basic: rates[indexPath.row].basic,
            buy: rates[indexPath.row].buy,
            sale: rates[indexPath.row].sale,
            deltaBuy: rates[indexPath.row].deltaBuy,
            deltaSale: rates[indexPath.row].deltaSale
        )
        
        return cell
    }
}
