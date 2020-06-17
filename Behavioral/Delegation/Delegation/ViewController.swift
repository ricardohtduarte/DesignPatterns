//
//  ViewController.swift
//  Delegation
//
//  Created by Ricardo Duarte on 03/06/2020.
//  Copyright © 2020 Ricardo Duarte. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var designPatternInfoLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        startButton.layer.cornerRadius = 30
    }

    @IBAction func didTapStartButton(_ sender: Any) {
        guard let delegateInfoViewController = storyboard?.instantiateViewController(identifier: "DelegateInfoViewController") as? DelegateInfoViewController else {
            return
        }
        delegateInfoViewController.delegate = self
        present(delegateInfoViewController, animated: true)
    }
}

extension ViewController: DesignPatternInfoDelegate {
    func didTapInfoButton(text: String) {
        designPatternInfoLabel.text = text
    }
}
