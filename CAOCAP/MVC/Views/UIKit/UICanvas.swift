//
//  UICanvas.swift
//  CAOCAP
//
//  Created by Azzam AL-Rashed on 01/01/2024.
//

import UIKit

/// A custom UIScrollView that manages a zoomable and scrollable canvas with a dotted background pattern..
class UICanvas: UIScrollView, UIScrollViewDelegate {
    
    // MARK: - Properties
    let canvas = UIView()
    var canvasHeightConstraint = NSLayoutConstraint()
    var canvasWidthConstraint = NSLayoutConstraint()
    
    // MARK: - Initializers
    
    /// Initializes a new UICanvas with a specified frame and pattern color.
    ///
    /// - Parameters:
    ///   - frame: The frame rectangle for the view, measured in points.
    ///   - color: The color to be used for the  the canvas background dotted pattern.
    init(frame: CGRect, color: UIColor) {
        super.init(frame: frame)
        delegate = self
        setupScrollView()
        setupCanvas(color: color)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    /// Configures the scroll view properties and layout.
    private func setupScrollView() {
        translatesAutoresizingMaskIntoConstraints = false
        minimumZoomScale = 0.3
        maximumZoomScale = 3.0
        zoomScale = 0.5
        contentInset = UIEdgeInsets(top: 200, left: 100, bottom: 200, right: 100)
        contentOffset = CGPoint(x: -50, y: -150)
        layoutIfNeeded()
    }
    
    /// Sets up the canvas view with initial properties and constraints.
    ///
    /// - Parameter color: The color to be used as the canvas background dotted pattern..
    func setupCanvas(color: UIColor) {
        addSubview(canvas)
        canvas.translatesAutoresizingMaskIntoConstraints = false
        canvas.layer.cornerRadius = 10
        canvas.backgroundColor = UIColor(patternImage: UIImage(named: "dot")!, tintColor: color)
        canvas.addGestureRecognizer(doubleTapZoom)
        canvas.isUserInteractionEnabled = true
        canvasHeightConstraint = canvas.heightAnchor.constraint(equalToConstant: frame.height + 200)
        canvasWidthConstraint = canvas.widthAnchor.constraint(equalToConstant: frame.width + 200 )
        canvasHeightConstraint.isActive = true
        canvasWidthConstraint.isActive = true
        canvas.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    // MARK: - Canvas Management
        
    /// Expands the canvas size if needed to fit its subviews.
    func expandCanvasIfNeeded() {
        canvas.layoutIfNeeded()
        canvas.subviews.forEach { view in
            if view.frame.maxY > canvasHeightConstraint.constant{
                canvasHeightConstraint.constant += 50
            }
            
            if view.frame.maxX > canvasWidthConstraint.constant || view.frame.minX < 0 {
                canvasWidthConstraint.constant += 50
            }
        }
    }
    
    /// Clears all subviews from the canvas.
    ///
    /// This is useful for updating the canvas with new content.
    func clearCanvas() {
        canvas.subviews.forEach({ $0.removeFromSuperview() })
    }
    
    /// Centers the canvas and applies a zoom scale.
    func centerCanvas() {
        print("\(#function)ing...")
        let centerPoint = CGPoint(x: canvas.frame.midX, y: canvas.frame.midY)
        zoom(toPoint: centerPoint, scale: 0.5, animated: true)
    }
    
    
    //MARK: - handle Zooming in/out
    
    /// Gesture recognizer for double-tap zooming.
    lazy var doubleTapZoom: UITapGestureRecognizer = {
        let zoomingTap = UITapGestureRecognizer(target: self, action: #selector(handleZoomingTap))
        zoomingTap.numberOfTapsRequired = 2
        return zoomingTap
    }()
    
    /// Handles the double-tap gesture to zoom in or out.
    ///
    /// - Parameter sender: The tap gesture recognizer.
    @objc func handleZoomingTap(sender: UITapGestureRecognizer) {
        let location = sender.location(in: sender.view)
        zoom(to: zoomRect(scale: zoomScale == minimumZoomScale ? maximumZoomScale : minimumZoomScale, center: location), animated: true)
    }
    
    /// Calculates the zoom rectangle for a given scale and center point.
    ///
    /// - Parameters:
    ///   - scale: The zoom scale to apply.
    ///   - center: The center point for the zoom rectangle.
    /// - Returns: The calculated zoom rectangle.
    func zoomRect(scale: CGFloat, center: CGPoint) -> CGRect {
        var zoomRect = CGRect.zero
        zoomRect.size.height = canvasHeightConstraint.constant / scale
        zoomRect.size.width = canvasWidthConstraint.constant / scale
        zoomRect.origin.x = center.x - (zoomRect.size.width / 2)
        zoomRect.origin.y = center.y - (zoomRect.size.height / 2)
        return zoomRect
    }
    
    // MARK: - UIScrollViewDelegate
    
    /// Returns the view that will be zoomed.
    ///
    /// - Parameter scrollView: The scroll view requesting the view.
    /// - Returns: The view to be zoomed.
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return canvas
    }
    
    /// Called when the scroll view has zoomed.
    ///
    /// - Parameter scrollView: The scroll view that has zoomed.
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        // TODO: Consider centering the canvas after zooming if needed.
    }
    
}
