//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Martin on 12/5/16.
//  Copyright © 2016 Martin Kowaleff. All rights reserved.
//

import Foundation

/*enum Optional<T>{
    case None
    case Some(T)
}*/

private func multiply (op1: Double, op2: Double) -> Double{
    return op1*op2
}

private func square (op1: Double) -> Double{
    return op1*op1
}

class CalculatorBrain{
    
    //private var accumulator: Double = 0.0
    // Don't need the 'Double' part
    private var accumulator = 0.0
    
    func setOperand(operand: Double){
        accumulator = operand
    }
    
    private var operations: Dictionary<String, Operation> = [
        "π":    Operation.Constant(M_PI),
        "e":    Operation.Constant(M_E),
        "C":    Operation.Constant(0.0),
        
        "%":    Operation.UnaryOperation({$0*0.01}),
        "+/-":  Operation.UnaryOperation({$0 * -1.0}),
        "√":    Operation.UnaryOperation(sqrt),
        
        "cos":  Operation.UnaryOperation(cos),
        "sin":  Operation.UnaryOperation(sin),
        "tan":  Operation.UnaryOperation(tan),
        "sec":  Operation.UnaryOperation({1.0 / cos($0)}),
        "csc":  Operation.UnaryOperation({1.0 / sin($0)}),
        "cot":  Operation.UnaryOperation({1.0 / tan($0)}),
        
        "x²" :  Operation.UnaryOperation({$0 * $0}),
        "x³":   Operation.UnaryOperation({$0 * $0 * $0}),
        "x⁻¹":  Operation.UnaryOperation({1.0 / $0}),
        "lnx":  Operation.UnaryOperation(log),
        "log₁₀x":Operation.UnaryOperation(log10),
        
        // This is called a "closure" and is used instead of defining all the separate functions for each operation:
        // $0 and $1 are the first and second parameter
        "×":    Operation.BinaryOperation({$0 * $1}),
        "÷":    Operation.BinaryOperation({$0 / $1}),
        "+":    Operation.BinaryOperation({$0 + $1}),
        "-":    Operation.BinaryOperation({$0 - $1}),
        
        
        "=":    Operation.Equals
    ]
    
    private enum Operation{
        // works by associated values (big thing in Swift)
        // enum is passed by value
        // class is passed by reference
        
        // case Integer(Integer)
        case Constant(Double)
        
        // Takes a Double as a parameter and returns a Double
        case UnaryOperation((Double) -> Double)
        case BinaryOperation((Double, Double) -> Double)
        case Equals
    }
    
    private var pending: PendingBinaryOperationInfo?
    // the variable 'pending' is of type 'PendingBinaryOperationInfo'
    
    struct PendingBinaryOperationInfo{
        
        //structs have only variables, no functions and doesn't support inheritance
        // a variable can be a function and a function can be a variable in Java&Swift
        
        var binaryFunction: (Double, Double) -> Double
        var firstOperand: Double
    }
    
    func performOperation(symbol: String){
        if let operation = operations[symbol] {
            switch operation {
            case .Constant(let myValue) :
                accumulator = myValue
                
            case .UnaryOperation(let function):
                accumulator = function(accumulator)
                
            case .BinaryOperation(let function):
                executePendingOperation()
                pending = PendingBinaryOperationInfo(binaryFunction: function,
                                                     firstOperand: accumulator)
            case .Equals:
                executePendingOperation()
            }
        }
        
        
        //if let constant = operations[symbol]{
            
            
            //accumulator = constant
        //}
        
        //accumulator = constant!
        // constant! unwraps the 'constant'
        
        /*switch symbol{
        case "π": accumulator = M_PI
        case "√": accumulator = sqrt(accumulator)
        case "C": accumulator = 0.0
        case "x²": accumulator = accumulator*accumulator
        default: break
        }*/
    }
    
    private func executePendingOperation() {
        if (pending != nil) {
            accumulator = pending!.binaryFunction(pending!.firstOperand, accumulator)
            pending = nil
        }
    }
    
    
    // This is a computed variable where you can provide the getter and setter
    var result: Double{
        get{
            return accumulator
        }
        
    }
}
