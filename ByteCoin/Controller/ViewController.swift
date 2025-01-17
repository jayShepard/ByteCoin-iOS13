//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var bitcoinLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    @IBOutlet weak var currencyLabel: UILabel!
    
    var coinManager = CoinManager()
    var selectedCoinCurrency: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        coinManager.delegate = self
    }
}

// MARK: - UIPicker functionality
extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCoinCurrency = coinManager.currencyArray[row]
        coinManager.getCoinPrice(for: selectedCoinCurrency!)
    }
}

// MARK: - CoinManagerDelegate
extension ViewController: CoinManagerDelegate {
    func didFailWithError(_ coinManager: CoinManager, error: Error) {
        print(error)
    }
    
    func didUpdateCurrency(_ coinManager: CoinManager, bitcoin: Double?) {
        DispatchQueue.main.async {
            self.bitcoinLabel.text = String(format: "%.2f", bitcoin ?? 0.00)
            self.currencyLabel.text = self.selectedCoinCurrency
        }
    }
}
