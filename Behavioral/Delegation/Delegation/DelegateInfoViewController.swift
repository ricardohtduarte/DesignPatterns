//
//  DelegateInfoViewController.swift
//  Delegation
//
//  Created by Ricardo Duarte on 15/06/2020.
//  Copyright © 2020 Ricardo Duarte. All rights reserved.
//

import UIKit

protocol DesignPatternInfoDelegate: class {
    func didTapInfoButton(text: String)
}

class DelegateInfoViewController: UIViewController {

    weak var delegate: DesignPatternInfoDelegate!

    @IBOutlet var configureInfoButtons: [UIButton]!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureInfoButtons.forEach { $0.layer.cornerRadius = 30 }
    }

    @IBAction func didTapInfoButton(_ sender: Any) {
        guard
            let button = sender as? UIButton,
            let text = button.titleLabel?.text else {
            return
        }
        delegate?.didTapInfoButton(text: text)
        dismiss(animated: true, completion: nil)
    }
}
