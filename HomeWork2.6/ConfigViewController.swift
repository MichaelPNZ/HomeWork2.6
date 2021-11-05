//
//  ViewController.swift
//  HomeWork2.6
//
//  Created by Михаил Позялов on 05.11.2021.
//

import UIKit

class ConfigViewController: UIViewController {
    
    @IBOutlet var redLabel: UILabel!
    @IBOutlet var greenLabel: UILabel!
    @IBOutlet var blueLabel: UILabel!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    @IBOutlet var redTextField: UITextField!
    @IBOutlet var greenTextField: UITextField!
    @IBOutlet var blueTextField: UITextField!
    
    @IBOutlet var colorView: UIView!
    
    var delegate: ConfigViewControllerDelegate!
    var colorFromView: UIColor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        colorView.layer.cornerRadius = 10
        
        redSlider.minimumTrackTintColor = .red
        greenSlider.minimumTrackTintColor = .green
        
        colorView.backgroundColor = colorFromView
        
        addDoneButtonTo(redTextField)
        addDoneButtonTo(greenTextField)
        addDoneButtonTo(blueTextField)
        
        changeColor()
        setValue(for: redLabel, greenLabel, blueLabel, and: redTextField, greenTextField, blueTextField)
    }

    @IBAction func redSliderAction() {
        changeColor()
        setValue(for: redLabel, and: redTextField)
    }
    
    @IBAction func greenSliderAction() {
        changeColor()
        setValue(for: greenLabel, and: greenTextField)
    }
    
    @IBAction func blueSliderAction() {
        changeColor()
        setValue(for: blueLabel, and: blueTextField)
    }
    
    @IBAction func redTextFieldAction(_ sender: UITextField) {
        
    }
    
    @IBAction func doneButtonPressed() {
        delegate.setColorStartingView(for: UIColor(displayP3Red: CGFloat(redSlider.value),
                                                   green: CGFloat(greenSlider.value),
                                                   blue: CGFloat(blueSlider.value),
                                                   alpha: 1))
        dismiss(animated: true)
    }
    
    func changeColor() {
        colorView.backgroundColor = UIColor(displayP3Red: CGFloat(redSlider.value),
                                            green: CGFloat(greenSlider.value),
                                            blue: CGFloat(blueSlider.value),
                                            alpha: 1)
    }
    
    private func setValue(for labels: UILabel..., and textFields: UITextField...) {
        labels.forEach { label in
            switch label {
            case redLabel:
                redLabel.text = string(from: redSlider)
            case greenLabel:
                greenLabel.text = string(from: greenSlider)
            default:
                blueLabel.text = string(from: blueSlider)
            }
        }
        
        textFields.forEach {
            textField in
            switch textField {
            case redTextField:
                redTextField.text = string(from: redSlider)
            case greenTextField:
                greenTextField.text = string(from: greenSlider)
            default:
                blueTextField.text = string(from: blueSlider)
            }
        }
    }
    
    private func string(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
    
}

extension ConfigViewController: UITextFieldDelegate {
        
        // Скрываем клавиатуру нажатием на "Done"
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return true
        }
        
        func textFieldDidEndEditing(_ textField: UITextField) {
            
            guard let text = textField.text else { return }
            
            if let currentValue = Float(text) {
                
                switch textField.tag {
                case 0: redSlider.value = currentValue
                case 1: greenSlider.value = currentValue
                case 2: blueSlider.value = currentValue
                default: break
                }

                changeColor()
            }
        }
    }

    extension ConfigViewController {
        
        // Метод для отображения кнопки "Готово" на цифровой клавиатуре
        private func addDoneButtonTo(_ textField: UITextField) {
            
            let numberToolbar = UIToolbar()
            textField.inputAccessoryView = numberToolbar
            numberToolbar.sizeToFit()
            
            let doneButton = UIBarButtonItem(title:"Done",
                                             style: .done,
                                             target: self,
                                             action: #selector(didTapDone))
            
            let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                                target: nil,
                                                action: nil)
            
            
            
            numberToolbar.items = [flexBarButton, doneButton]
            
        }
        
        @objc private func didTapDone() {
            view.endEditing(true)
        }
    }


//extension UITextField{
//
//        @IBInspectable var doneAccessory: Bool{
//            get{
//                return self.doneAccessory
//            }
//            set (hasDone) {
//                if hasDone{
//                    addDoneButtonOnKeyboard()
//                }
//            }
//        }
//
//        func addDoneButtonOnKeyboard()
//        {
//            let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
//            doneToolbar.barStyle = .default
//
//            let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
//            let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
//
//            let items = [flexSpace, done]
//            doneToolbar.items = items
//            doneToolbar.sizeToFit()
//
//            self.inputAccessoryView = doneToolbar
//        }
//
//        @objc func doneButtonAction() {
//            self.resignFirstResponder()
//        }
//
//    }
