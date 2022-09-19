//
//  CalculatorManager.swift
//  Task8
//
//  Created by neoviso on 9/19/22.
//

import Foundation

class CalculatorManager {
    
    func getValidation(_ expression: String, _ input: String) -> String {
        if expression == "" && Character(input).isMathOperator { return expression }
        
        if expression.last?.isMathOperator ?? false && Character(input).isMathOperator {
            if input == "." || expression.last ?? "." == "." { return expression }
            
            var lastRemoved = expression
            lastRemoved.removeLast()
            return lastRemoved + input
        }
        let numbers = expression.components(separatedBy: ["-", "*", "/", "+"])
        
        if input == "." && numbers.last?.contains(".") ?? true { return expression }
        
        if numbers.last ?? " " == "0" {
            guard input != "0" else { return expression }
            
            guard Character(input).isMathOperator else {
                var lastRemoved = expression
                lastRemoved.removeLast()
                return lastRemoved + input
            }
        }
        return expression + input
    }
    
    func getEquality(_ expression: String) -> String {
        guard expression.last?.isMathOperator == false else { return expression }
        
        let result = NSExpression(format:expression).toFloat().expressionValue(with: nil, context: nil)
        let resultString = String(describing: result ?? expression)
        return resultString
    }
    
    func getPlusMinus(_ expression: String) -> String {
        
        guard expression.last?.isMathOperator == false else { return expression }

        let numbers = expression.components(separatedBy: ["-", "*", "/", "+"])
        let lastNumber = numbers.last ?? ""
        
        guard let result = Double(lastNumber) else { return expression }
        
        
        
        let convertedNumber = -1 * result
        var lastNumberPlusMinus: String

        if convertedNumber == floor(convertedNumber){ lastNumberPlusMinus = String(Int(convertedNumber)) }
        else { lastNumberPlusMinus = String(convertedNumber) }
        
        let range = expression.range(of: String(lastNumber))!
        let firstOccurrence = expression.replacingCharacters(in: range, with: "")
        var resultString = firstOccurrence + String(lastNumberPlusMinus)
        
        if firstOccurrence.count >= 2 && firstOccurrence.last! == "-" {
            resultString = resultString.replacingOccurrences(of: "--", with: "+")
        } else {
            resultString = resultString.replacingOccurrences(of: "--", with: "")
        }
        return resultString
    }
    
    func getPercent(_ expression: String) -> String {
        guard expression.last?.isMathOperator == false else { return expression }
        
        let numbers = expression.components(separatedBy: ["-", "*", "/", "+"])
        let percent = numbers.last ?? ""
        
        guard let result = Double(percent) else { return expression }
        
        let convertedPercent = result / 100
        let range = expression.range(of: String(percent))!
        let withoutLastNumber = expression.replacingCharacters(in: range, with: "")
        return withoutLastNumber + String(convertedPercent)
    }
}

extension NSExpression {
    func toFloat() -> NSExpression {
        switch expressionType {
        case .constantValue:
            if let value = constantValue as? NSNumber {
                return NSExpression(forConstantValue: NSNumber(value: value.doubleValue))
            }
        case .function:
           let newArgs = arguments.map { $0.map { $0.toFloat() } }
           return NSExpression(forFunction: operand, selectorName: function, arguments: newArgs)
        default:
            break
        }
        return self
    }
}

extension Character {
    var isMathOperator: Bool {
        return self == "*" || self == "/" || self == "+" || self == "-" || self == "."
    }
}
