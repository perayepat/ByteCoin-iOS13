//
//  CoinModel.swift
//  ByteCoin
//
//  Created by Pat on 2022/08/10.
//  Copyright © 2022 The App Brewery. All rights reserved.
//

import Foundation

struct CoinModel {
    var time: String
    var assetIDBase: String
    var assetIDQuote: String
    var rate: Double
    var rateString: String{
        return String(format: "%.2f", rate)
    }
}
