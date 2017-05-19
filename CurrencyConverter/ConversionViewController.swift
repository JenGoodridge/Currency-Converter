//
//  ConversionViewController.swift
//  CurrencyConverter
//
//  Created by Jennifer Goodridge on 4/28/17.
//  Copyright © 2017 Jennifer Goodridge. All rights reserved.
//
import Foundation

import UIKit

class ConversionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    
    
    // MARK: - Properties
    
    
    @IBOutlet weak var currenciesTable: UITableView!
    
    @IBOutlet weak var amountTextField: UITextField!
    
    @IBOutlet weak var currencyLabel: UILabel!
    
    public var sourceCurrency: String? = nil
    
    var currency = ["AUD", "CAD", "EUR", "GBP", "INR", "ILS", "MXN", "RUB", "USD", "YEN", "CNY" ]
    var conversionRates = [1.33, 1.36, 0.91, 0.77, 64.15, 3.61, 18.79, 56.91, 1.0, 111.49, 6.89 ]
    let inputFormatter = NumberFormatter()
    let outputFormatter = NumberFormatter()
    var symbols = ["$", "$", "€", "£", "₹", "₪", "$", "₽", "$", "¥", "¥"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currencyLabel.text = sourceCurrency
        currenciesTable.dataSource = self
        currenciesTable.delegate = self
        
        amountTextField.keyboardType = .decimalPad
        amountTextField.delegate = self
        
        inputFormatter.numberStyle = .decimal
        outputFormatter.numberStyle = .currency
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currency.count
    }
    
    func findIndex() -> Int{
        var i = 0
        for money in currency{
            
            if money == sourceCurrency{
                break
            }
            i += 1
        }
        
        return i
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "CurrenciesTableCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        cell.textLabel?.text = currency[indexPath.row]
        
        let text = self.amountTextField.text ?? ""
        if let value = inputFormatter.number(from: text) {
            
            if sourceCurrency == "USD" {
                
            
            let convertedAmnt = Double(value) * conversionRates[indexPath.row]
            cell.detailTextLabel?.text = String(convertedAmnt)
            
            }
            else{
                
                let convertedUSD = Double(value) / conversionRates[findIndex()]
                let convertedAmnt = convertedUSD * conversionRates[indexPath.row]
                outputFormatter.currencySymbol = symbols[indexPath.row]
                cell.detailTextLabel?.text = outputFormatter.string(from: NSNumber(value: convertedAmnt))!
            }
        } else {
            cell.detailTextLabel?.text = ""
        }
        
        return cell
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = ((textField.text ?? "") as NSString).replacingCharacters(in: range, with: string)
        let shouldUpdate = text.isEmpty || inputFormatter.number(from: text) != nil
        if shouldUpdate {
            self.amountTextField.text = text
            self.currenciesTable.reloadData()
        }
        
        return false
    }
}
