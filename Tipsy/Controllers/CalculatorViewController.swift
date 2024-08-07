//
//  ViewController.swift
//  Tipsy
//
//  Created by Zeynep HAYKIR on 2024-08-06.

import UIKit

class CalculatorViewController: UIViewController {

    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!
    
    var tip = 0.10
    var numberOfPeople = 2
    var totalBill = 0.0
    var finalResult = "0.0"

    @IBAction func tipChanged(_ sender: UIButton) {
        
        // Dismiss the keyboard when the user chooses one of the tip values.
        billTextField.endEditing(true)
        
        zeroPctButton.isSelected = false
        tenPctButton.isSelected = false
        twentyPctButton.isSelected = false
        sender.isSelected = true
        
        // Get the current title of the button that was pressed.
        let buttonTitle  = sender.currentTitle!
        
        // Remove the last character (%) from the title then turn it back into a String.
        let buttonTitleMinusPercentSign =  String(buttonTitle.dropLast())
        
        // Turn the String into a Double.
        let buttonTitleAsANumber = Double(buttonTitleMinusPercentSign)!
        
        tip = buttonTitleAsANumber / 100
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        // Get the stepper value using sender.value, round it down to a whole number then set it as the text in
        //the splitNumberLabel
        splitNumberLabel.text = String(format: "%.0f", sender.value)
        
        // Set the numberOfPeople property as the value of the stepper as a whole number.
        numberOfPeople = Int(sender.value)
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        let bill = billTextField.text!
        
        // if bill is not empty string
        if bill != "" {
            totalBill = Double(bill)!       //turn bill from string to double
            
            // Multiply the bill by the tip percentage and divide by the number of people to split the bill.
            let result = totalBill * (1 + tip) / Double(numberOfPeople)
            
            // Round the result to 2 decimal places and turn it into a String.
            //let resultTo2DecimalPlaces = String(format: "%.2f", result)
            //print(resultTo2DecimalPlaces)
            
            finalResult = String(format:"%.2f", result)
            
            self.performSegue(withIdentifier: "goToResult", sender: self)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult" {
            
            // Get hold of the instance of the destination VC and type cast it to a ResultViewController.
            let destinationVC = segue.destination as! ResultsViewController
            destinationVC.result = finalResult
            destinationVC.tip = Int(tip*100)
            destinationVC.split = numberOfPeople
        }
    }
    
}

