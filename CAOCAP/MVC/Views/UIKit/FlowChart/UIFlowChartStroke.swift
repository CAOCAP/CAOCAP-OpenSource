//
//  UIFlowChartStroke.swift
//  CAOCAP
//
//  Created by الشيخ عزام on 09/08/2024.
//

import UIKit

/// A custom view for drawing a series of strokes between FlowChart nodes.
class UIFlowChartStroke: UIView {
    
    // MARK: - Properties
    var lines = 0
    var color = UIColor.label
    var heightConstraint = NSLayoutConstraint()
    var widthConstraint = NSLayoutConstraint()
    
    // MARK: - Initializers
    /// Initializes the stroke view with the specified number of lines.
    ///
    /// - Parameter lines: The number of lines to draw. Defaults to 0.
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
    
    // MARK: - Drawing
    
    override func draw(_ rect: CGRect) {
        
    }
}
