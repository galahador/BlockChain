//
//  CustomButton.swift
//  BlockChain_Logic
//
//  Created by Petar Lemajic on 1/2/19.
//  Copyright © 2019 Petar Lemajic. All rights reserved.
//

import UIKit

@IBDesignable
class CustomButton: UIButton {
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }

    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }

    @IBInspectable var borderColor: UIColor = .black {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }

    @IBInspectable var shadowOpacity: Float = 0.0 {
        didSet {
            layer.shadowOpacity = shadowOpacity
            layer.shadowOffset = CGSize(width: 0, height: 10)
            layer.shadowRadius = 10
        }
    }
}

/*
 This is main test for conflict!
 */
