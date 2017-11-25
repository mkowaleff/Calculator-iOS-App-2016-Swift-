//
//  ViewController.swift
//  Calculator
//
//  Created by Martin on 11/7/16.
//  Copyright © 2016 Martin Kowaleff. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // Creates the variable AND initializes it (after '=' sign)
    // private var brain: CalculatorBrain = CalculatorBrain()
    // don't have to say brain: CalculatorBrain, swift knows automatically even though it is strongly typed
    
    private var brain = CalculatorBrain()
    
    @IBOutlet private weak var display: UILabel!
    
    // ? and ! essentially mean the same thing, we will use ! strictly for unwrapping
    
    private var userIsInTheMiddleOfTyping : Bool = false
    
    private var displayValue : Double {
        get {
            return Double(self.display.text!)!
        }
        
        set {
            display.text = String(newValue)
        }
    }
    
    @IBAction private func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        //unwraps the "optional" String value to a real string
        print("Touched \(digit) button.")
        
        let textCurrentlyInDisplay = display!.text
        
        if(userIsInTheMiddleOfTyping){
            display!.text = textCurrentlyInDisplay! + digit
        }
        else{
            display!.text = digit
        }
        userIsInTheMiddleOfTyping = true
    }
    
    @IBAction private func performOperation(_ sender: UIButton) {
        if(userIsInTheMiddleOfTyping){
            brain.setOperand(operand: displayValue)
            userIsInTheMiddleOfTyping = false
        }
        
        if let mathematicalSymbol = sender.currentTitle{
            
            // if there is a variable mathematicalSymbol/if it unpacked/if sender.currentTitle!=nil
            //if there is a mathematical symbol we're being given
            
            brain.performOperation(symbol: mathematicalSymbol)
            
        }
        
        displayValue = brain.result
        
        // Old Code:
        /* userIsInTheMiddleOfTyping = false
         let mathematicalSymbol = sender.currentTitle!
         if(mathematicalSymbol == "π"){
         displayValue = M_PI
         
         }
         else if(mathematicalSymbol == "√"){
         displayValue = sqrt(displayValue)
         }
         else if(mathematicalSymbol == "C"){
         displayValue = 0
         }*/
    }
    
    
}

