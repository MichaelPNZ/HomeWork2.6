//
//  StartingViewController.swift
//  HomeWork2.6
//
//  Created by Михаил Позялов on 05.11.2021.
//

import UIKit

protocol ConfigViewControllerDelegate {
    func setColorStartingView(for background: UIColor)
}

class StartingViewController: UIViewController {
  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     let configVC = segue.destination as! ConfigViewController
        configVC.colorFromView = view.backgroundColor
        configVC.delegate = self
    }
}

extension StartingViewController: ConfigViewControllerDelegate {
    func setColorStartingView(for background: UIColor) {
        view.backgroundColor = background
    }
}
