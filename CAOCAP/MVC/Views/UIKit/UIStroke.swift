//
//  UIStroke.swift
//  CAOCAP
//
//  Created by Azzam AL-Rashed on 21/06/2023.
//

import UIKit

class UIStroke: UIView {
    var lines = 0
    var color = UIColor.label
    var heightConstraint = NSLayoutConstraint()
    var widthConstraint = NSLayoutConstraint()
    
    init(lines: Int = 0) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.clear
        self.lines = lines
        heightConstraint = heightAnchor.constraint(equalToConstant: 60)  //TODO: use SnapKit
        widthConstraint = widthAnchor.constraint(equalToConstant: 0)  //TODO: use SnapKit
        heightConstraint.isActive = true
        widthConstraint.isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath()
        path.lineWidth = 4
        color.setStroke()
        
        let centerPosition = Int(lines/2)
        let point1 = CGPoint(x: widthConstraint.constant/2, y: heightConstraint.constant/2)
        for index in 0...lines - 1 {
            path.move(to: CGPoint(x: widthConstraint.constant/2, y: 0))
            var xConstant: CGFloat
            if lines % 2 == 0 {
                // even number of lines ( two lines near the centre )
                if index == centerPosition {
                    //near centre right line
                    xConstant = widthConstraint.constant/2 + 90
                } else if index == centerPosition - 1 {
                    //near centre left line
                    xConstant = widthConstraint.constant/2 - 90
                } else {
                    //push to the right or left| i am 0 of 4 -> 0 - 2 + 0.5 -> -1.5*180, i am 3 of 4 -> 3 - 2 + 0.5 -> 1.5*180
                    let multiplier = Double(index - centerPosition) + 0.5
                    xConstant = widthConstraint.constant/2 + multiplier * 180
                }
            } else {
                // odd number of lines ( one centered line )
                if index == centerPosition {
                    //centered line
                    xConstant = widthConstraint.constant/2
                } else {
                    //push to the right or left
                    let multiplier = Double(index - centerPosition)
                    xConstant = widthConstraint.constant/2 + multiplier * 180
                }
            }
            
            let point2 = CGPoint(x: xConstant, y: heightConstraint.constant/3)
            path.addCurve(to: CGPoint(x: xConstant, y: heightConstraint.constant), controlPoint1: point1, controlPoint2: point2)
        }
        path.stroke()
    }
}
