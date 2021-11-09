//
//  ViewController.swift
//  HomeWork2.6
//
//  Created by Михаил Позялов on 05.11.2021.
//

import UIKit

class ConfigViewController: UIViewController {
    
    @IBOutlet var colorView: UIView!
    
    @IBOutlet var redLabel: UILabel!
    @IBOutlet var greenLabel: UILabel!
    @IBOutlet var blueLabel: UILabel!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    @IBOutlet var redTextField: UITextField!
    @IBOutlet var greenTextField: UITextField!
    @IBOutlet var blueTextField: UITextField!
    
    var delegate: ConfigViewControllerDelegate!
    var colorFromView: UIColor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorView.layer.cornerRadius = 10
        
        redSlider.minimumTrackTintColor = .red
        greenSlider.minimumTrackTintColor = .green
        
        colorView.backgroundColor = colorFromView
        
        setSladers()
        setValue(redLabel, greenLabel, blueLabel)
        setValue(redTextField, greenTextField, blueTextField)
    }
    
    @IBAction func rgbSliders(_ sender: UISlider) {
        switch sender {
        case redSlider:
            setValue(redLabel)
            setValue(redTextField)
        case greenSlider:
            setValue(greenLabel)
            setValue(greenTextField)
        default:
            setValue(blueLabel)
            setValue(blueTextField)
            
        }
        changeColor()
    }
    
    @IBAction func doneButtonPressed() {
        delegate?.setColorStartingView(colorView.backgroundColor ?? .white)
        dismiss(animated: true)
    }
    
}
extension ConfigViewController {
    
    private func changeColor() {
        colorView.backgroundColor = UIColor(
            displayP3Red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1)
    }
    
    private func setValue(_ labels: UILabel...) {
        labels.forEach { label in
            switch label {
            case redLabel:
                label.text = string(from: redSlider)
            case greenLabel:
                label.text = string(from: greenSlider)
            default:
                label.text = string(from: blueSlider)
            }
        }
    }
    
    private func setValue(_ textFields: UITextField...) {
        textFields.forEach {textField in
            switch textField {
            case redTextField:
                textField.text = string(from: redSlider)
            case greenTextField:
                textField.text = string(from: greenSlider)
            default:
                textField.text = string(from: blueSlider)
            }
        }
    }
    
    private func setSladers() {
        let ciColor = CIColor(color: colorFromView)
        
        redSlider.value = Float(ciColor.red)
        greenSlider.value = Float(ciColor.green)
        blueSlider.value = Float(ciColor.blue)
    }
    
    private func string(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
    
    @objc private func didTapDone() {
        view.endEditing(true)
    }
    
    private func showAlert(title: String, messege: String) {
        let alert = UIAlertController(title: title, message: messege, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
}

extension ConfigViewController: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        guard let text = textField.text else { return }
        
        if let currentValue = Float(text) {
            switch textField {
            case redTextField:
                redSlider.setValue(currentValue, animated: true)
                setValue(redLabel)
            case greenTextField:
                greenSlider.setValue(currentValue, animated: true)
                setValue(greenLabel)
            default:
                blueSlider.setValue(currentValue, animated: true)
                setValue(blueLabel)
            }
            changeColor()
            return
        }
        showAlert(title: "Wrong format!", messege: "Please enter correct value")
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        let numberToolbar = UIToolbar()
        numberToolbar.sizeToFit()
        textField.inputAccessoryView = numberToolbar
        
        let doneButton = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(didTapDone)
        )
        
        let flexBarButton = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil)
        
        numberToolbar.items = [flexBarButton, doneButton]
    }
}

