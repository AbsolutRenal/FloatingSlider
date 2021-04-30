//
//  ViewController.swift
//  FloatingSlider
//
//  Created by Renaud Cousin on 4/30/21.
//

import UIKit

class ViewController: UIViewController {

    private let slider = FloatingSlider()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        setup()
    }

    private func setup() {
        view.backgroundColor = .darkGray

        slider.minimumValue = 0.0
        slider.maximumValue = 100.0
        slider.tintColor = .systemTeal

        slider.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(slider)

        NSLayoutConstraint.activate([
            slider.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            slider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            slider.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}

