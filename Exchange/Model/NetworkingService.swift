//
//  NetworkingService.swift
//  Exchange
//
//  Created by Maxim Bekmetov on 29.10.2021.
//

import Foundation

protocol NetworkingServiceDelegate {
    func didUpdateCurrency(_ networkingService: NetworkingService, currency: CurrencyData)
    func didFailWithError(error: Error)
}

struct NetworkingService {
    
    var delegate: NetworkingServiceDelegate?
    
    func getRequest() {
        guard let url = URL(string: "https://alpha.as50464.net:29870/moby-pre-44/core?r=BEYkZbmV&d=563B4852-6D4B-49D6-A86E-B273DD520FD2&t=ExchangeRates&v=44") else { return }
        var request = URLRequest(url: url)
        
        request.setValue("Test GeekBrains iOS 3.0.0.182 (iPhone 11; iOS 14.4.1; Scale/2.00; Private)", forHTTPHeaderField: "User-Agent")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        request.httpMethod = "POST"
        let postString = "{\"uid\":\"563B4852-6D4B-49D6-A86E-B273DD520FD2\",\"type\":\"ExchangeRates\",\"rid\":\"BEYkZbmV\"}"
        request.httpBody = postString.data(using: .utf8)
        
        // Getting response for POST Method
        DispatchQueue.main.async {
            URLSession.shared.dataTask(with: request) { data, response, error in
                
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                guard let safeData = data else { return }
                
                if let currency = self.parseJSON(safeData) {
                    self.delegate?.didUpdateCurrency(self, currency: currency)
                }
                
            }.resume()
        }
    }
    
    func parseJSON(_ currencyData: Data) -> CurrencyData? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CurrencyData.self, from: currencyData)
            let code = decodedData.code
            let messageTitle = decodedData.messageTitle
            let message = decodedData.message
            let rid = decodedData.rid
            let downloadDate = decodedData.downloadDate
            let rates = decodedData.rates
            let productState = decodedData.productState
            let ratesDate = decodedData.ratesDate
            
            let currency = CurrencyData(code: code, messageTitle: messageTitle, message: message, rid: rid, downloadDate: downloadDate, rates: rates, productState: productState, ratesDate: ratesDate)
            return currency
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
}
