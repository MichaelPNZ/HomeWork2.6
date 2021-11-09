//
//  StartingViewController.swift
//  HomeWork2.6
//
//  Created by Михаил Позялов on 05.11.2021.
//

import UIKit

protocol ConfigViewControllerDelegate {
    func setColorStartingView(_ background: UIColor)
}

class StartingViewController: UIViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let configVC = segue.destination as? ConfigViewController else { return }
        configVC.delegate = self
        configVC.colorFromView = view.backgroundColor
    }
}

extension StartingViewController: ConfigViewControllerDelegate {
    func setColorStartingView(_ background: UIColor) {
        view.backgroundColor = background
    }
}
