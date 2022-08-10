//
//  CoinModel.swift
//  ByteCoin
//
//  Created by Pat on 2022/08/10.
//  Copyright © 2022 The App Brewery. All rights reserved.
//

import Foundation

struct CoinData: Codable {
    var time: String
    var assetIDBase: String
    var assetIDQuote: String
    var rate: Double

    enum CodingKeys: String, CodingKey {
        case time
        case assetIDBase = "asset_id_base"
        case assetIDQuote = "asset_id_quote"
        case rate
    }
}

