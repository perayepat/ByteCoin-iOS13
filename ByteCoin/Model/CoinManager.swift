//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation
import SwiftUI

protocol CoinManagerDelegate {
    func didUpadateCoin(_ coinManager: CoinManager,_ coin:CoinModel)
    func didFailWithError(error:Error)
}

struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "7C18E076-C5C3-4301-8ACF-C7004D7DD47F"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    var currencyPoint = 0
    
    var delegate: CoinManagerDelegate?

    func getCoinPrice(for currency: String){
        let urlString = "\(baseURL)/\(currency)?apikey=\(apiKey)"
        peformRequest(with: urlString)
    }
    //https://rest.coinapi.io/v1/exchangerate/BTC/USD?apikey=7C18E076-C5C3-4301-8ACF-C7004D7DD47F
   
    
    
    func peformRequest(with urlString: String){
        guard let url = URL(string: urlString) else { return }
        let session  = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            if error != nil {
                delegate?.didFailWithError(error: error!)
                return
            }
            if let safeData = data{
                    //Decode Json
                guard let coin = parseJSON(safeData) else { return }
                delegate?.didUpadateCoin(self, coin)
            }
        }
        task.resume()
    }
    func parseJSON(_ coinData: Data) -> CoinModel?{
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(CoinData.self, from: coinData)
            //Change Weather Icon
            let time = decodedData.time
            let assetIDBase = decodedData.assetIDBase
            let assetIDQuote = decodedData.assetIDQuote
            let rate = decodedData.rate
            let coin = CoinModel(time: time, assetIDBase: assetIDBase, assetIDQuote: assetIDQuote, rate: rate)
            
            return coin
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
}
