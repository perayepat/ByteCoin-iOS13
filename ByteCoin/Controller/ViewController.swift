//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController{


    @IBOutlet weak var bitcoinLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    @IBOutlet weak var currentLabel: UILabel!
    var coinManager = CoinManager()
    var coinSelected : String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        coinManager.delegate = self
    }

}
//MARK: - Picker Controls
extension ViewController:UIPickerViewDataSource, UIPickerViewDelegate{
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let currencyPicked = coinManager.currencyArray[row]
        coinSelected = currencyPicked
        coinManager.getCoinPrice(for: currencyPicked)
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        //assign the text in the array to the corresponsinf point in the array
        
        return coinManager.currencyArray[row]
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        //assign the number of picker slots to the picker using the array
        return coinManager.currencyArray.count
    }
}

//MARK: - Coin Manager Delegate
extension ViewController:CoinManagerDelegate{
    func didUpadateCoin(_ coinManager: CoinManager, _ coin: CoinModel) {
        DispatchQueue.main.async {
            self.currentLabel.text = ""
            self.currentLabel.text = "\(coin.rateString) \(self.coinSelected)"
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

