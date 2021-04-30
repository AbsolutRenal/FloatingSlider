//
//  FloatingSlider.swift
//  FloatingSlider
//
//  Created by Renaud Cousin on 4/30/21.
//

import Foundation
import UIKit

final class FloatingSlider: UISlider {
    private(set) var isDragging: Bool = false
    private lazy var currentTimeLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = self.tintColor
        label.textColor = .white
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 12)
        label.layer.cornerRadius = 6
        label.alpha = 0
        label.layer.masksToBounds = true
        label.transform = hiddenTransform
        return label
    }()
    private let hiddenTransform = CGAffineTransform(translationX: 0, y: 20)

    override func layoutSubviews() {
        super.layoutSubviews()
        if currentTimeLabel.superview == nil {
            setupLabel()
        }

        updateValueLabel()
    }

    private func updateValueLabel() {
        currentTimeLabel.text = "\(self.value.rounded(.toNearestOrEven))"
        let thumbFrame = thumbRect(forBounds: bounds,
                                   trackRect: trackRect(forBounds: bounds),
                                   value: self.value)
        let labelCenter = CGPoint(x: thumbFrame.midX,
                                  y: thumbFrame.minY).applying(CGAffineTransform(translationX: 0, y: -20))
        currentTimeLabel.frame = CGRect(origin: .zero, size: CGSize(width: 36, height: 22))
        currentTimeLabel.center = labelCenter
    }

    private func setupLabel() {
        addSubview(currentTimeLabel)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        isDragging = true

        displayLabel()
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        isDragging = false
        hideLabel()
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        isDragging = false
        hideLabel()
    }

    private func displayLabel() {
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 0,
                       options: .curveEaseInOut) {
            self.currentTimeLabel.transform = .identity
            self.currentTimeLabel.alpha = 1
        } completion: { (_) in

        }
    }

    private func hideLabel() {
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 1,
                       initialSpringVelocity: 0,
                       options: .curveEaseInOut) {
            self.currentTimeLabel.transform = self.hiddenTransform
            self.currentTimeLabel.alpha = 0
        } completion: { (_) in

        }
    }
}
