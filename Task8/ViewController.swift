//
//  ViewController.swift
//  Task8
//
//  Created by neoviso on 9/19/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var expressionLabel: UILabel!
    @IBOutlet var calcButtons: [UIButton]!
    
    let calculatorManager = CalculatorManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        expressionLabel.text = "0"
        
        for button in calcButtons {
            button.layer.cornerRadius = button.frame.size.height / 3.2
        }
    }
    
    @IBAction func numbersAndOperationsButton(_ sender: UIButton) {
        guard let value = sender.titleLabel?.text else { return }
        let expression = expressionLabel.text ?? ""
        let result = calculatorManager.getValidation(expression, value)
        expressionLabel.text = result
    }
    
    @IBAction func expressionResultButton(_ sender: UIButton) {
        let expression = expressionLabel.text ?? ""
        let result = calculatorManager.getEquality(expression)
        expressionLabel.text = result
    }
    
    @IBAction func percentOperatorButton(_ sender: UIButton) {
        let expression = expressionLabel.text ?? ""
        let result = calculatorManager.getPercent(expression)
        expressionLabel.text = result
    }
    
    @IBAction func plusAndMinusOperatorButton(_ sender: UIButton) {
        let expression = expressionLabel.text ?? ""
        let result = calculatorManager.getPlusMinus(expression)
        expressionLabel.text = result
    }
    
    @IBAction func clearOperatorButton(_ sender: UIButton) {
        expressionLabel.text = ""
    }
}

