//
//  GradientView.swift
//  Guac-A-Mole
//
//  Created by Forat Bahrani on 12/6/19.
//  Copyright © 2019 Forat Bahrani. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
public class GradientView : UIView {
    @IBInspectable var top : UIColor = .clear
    @IBInspectable var bottom : UIColor = .clear
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundColor = .clear
        addGradient(from: top, to: bottom, direction: .topToBottom)
    }
}



public enum GradientDirection {
    case topToBottom // top to bottom
    case bottomToTop // bottom to top
    case leftToRight // left to right
    case rightToLeft // right to left
    case topLeftToBottomRight // top left to bottom right
    case topRightToBottomLeft // top right to bottom left
    case bottomLeftToTopRight // bottom left to top right
    case bottomRightToTopLeft // bottom right to top left
}

public extension UIView {
    func addGradient(from: UIColor, to: UIColor, direction: GradientDirection, cornerRadius: CGFloat = 0)
    {
        if let layers = self.layer.sublayers {
            for layer in layers {
                if layer is CAGradientLayer {
                    layer.removeFromSuperlayer()
                }
            }
        }
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = [from.cgColor, to.cgColor]
        gradient.cornerRadius = cornerRadius
        gradient.masksToBounds = true
        
        switch direction
        {
        case .leftToRight:
            gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
            gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        case .rightToLeft:
            gradient.startPoint = CGPoint(x: 1.0, y: 0.5)
            gradient.endPoint = CGPoint(x: 0.0, y: 0.5)
        case .bottomToTop:
            gradient.startPoint = CGPoint(x: 0.5, y: 1.0)
            gradient.endPoint = CGPoint(x: 0.5, y: 0.0)
        case .topToBottom:
            gradient.startPoint = CGPoint(x: 0.5, y: 0.0)
            gradient.endPoint = CGPoint(x: 0.5, y: 1.0)
        case .topLeftToBottomRight:
            gradient.startPoint = CGPoint.zero
            gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        case .topRightToBottomLeft:
            gradient.startPoint = CGPoint(x: 1.0, y: 0.0)
            gradient.endPoint = CGPoint(x: 0.0, y: 1.0)
        case .bottomLeftToTopRight:
            gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
            gradient.endPoint = CGPoint(x: 1.0, y: 0.0)
        case .bottomRightToTopLeft:
            gradient.startPoint = CGPoint(x: 1.0, y: 1.0)
            gradient.endPoint = CGPoint.zero
        }
        
        self.layer.insertSublayer(gradient, at: 0)
    }
}
