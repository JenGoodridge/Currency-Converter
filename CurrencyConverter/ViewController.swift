//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Jennifer Goodridge on 4/28/17.
//  Copyright © 2017 Jennifer Goodridge. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var selectLabel: UILabel!
    
    @IBOutlet weak var welcomeLabel: UILabel!
    
    
    @IBAction func continueButton(_ sender: Any) {
    }
    
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    let currencies = ["AUD", "CAD", "EUR", "GBP", "INR", "ILS", "MXN", "RUB", "USD", "YEN", "CNY" ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }


    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencies.count
    }
  
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencies[row]
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if let destination = segue.destination as? ConversionViewController {
            destination.sourceCurrency = currencies[self.currencyPicker.selectedRow(inComponent: 0)]
            
        }
    }
}

