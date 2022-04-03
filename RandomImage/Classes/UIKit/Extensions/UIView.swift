//
//  UIView.swift
//  RandomImage
//
//  Created by Alexander Rogov on 03.04.2022.
//

import UIKit

extension UIView {
    func addSubviews(_ subviews: [UIView]) {
        subviews.forEach { addSubview($0) }
    }
}