//
//  UIStyleSheet.swift
//  CAOCAP
//
//  Created by الشيخ عزام on 11/08/2024.
//

import UIKit
import SnapKit

/// A protocol for handling events related to the style sheet
protocol UIStyleSheetDelegate {
    /// Called when a node is removed from the style sheet
    func didRemoveStyleSheetNode()
}

/// A custom view for displaying and managing a style sheet on a canvas.
class UIStyleSheet: UICanvas {
    
    
    // MARK: - Properties
    var project: Project?
    var nodeTree = [String: UIStyleSheetNode]()
    var styleSheetDelegate: UIStyleSheetDelegate?
    
    
    // MARK: - Load and Display Elements
    
    // Loads and displays the root selector of the project's document on the canvas.
    func loadSelector() {
        print("\(#function)ing...")
        //TODO: - loadSelector()
        clearCanvas()
        draw()
    }
    
    /// Recursively loads and displays the children of the given element.
    /// - Parameter children: The children elements to load and display.
    func load() {
        print("\(#function)ing...")
        //TODO: - load(children: Elements)
    }
    
    // MARK: - Draw Elements
    
    /// Draws a node for the given element and adds it to the canvas.
    /// - Parameter element: The element to draw on the canvas.
    func draw() {
        print("\(#function)ing...")
        //TODO: - draw(_ element: Element)
        let nodeView = UIStyleSheetNode()
        nodeTree["root"] = nodeView
        nodeView.delegate = self
        canvas.addSubview(nodeView)
        setNodePosition(nodeView)
        drawNodeStrokes(nodeView)
        expandCanvasIfNeeded()
    }
    
    /// Sets the position constraints for a node view on the canvas.
    /// - Parameter nodeView: The node view to position.
    func setNodePosition(_ nodeView: UIStyleSheetNode) {
        print("\(#function)ing...")
        //TODO: - setNodePosition(_ nodeView: UIFlowChartNode)
        nodeView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(400)
        }
    }
    
    /// Draws connection strokes between nodes on the canvas.
    /// - Parameter nodeView: The node view for which to draw strokes.
    func drawNodeStrokes(_ nodeView: UIStyleSheetNode) {
        print("\(#function)ing...")
        //TODO: - drawNodeStrokes(_ nodeView: UIFlowChartNode)
    }
    
    // MARK: - Add, Delete, and Select Nodes
    
    /// Adds a new node to the flow chart
    func add() {
        print("\(#function)ing...")
        //TODO: - add()
    }
    
    /// Deletes the specified element from the flow chart
    /// - Parameter element: The element to delete.
    func delete() {
        print("\(#function)ing...")
        //TODO: - delete()
    }
    
    /// Selects a node by its ID and zooms to it.
    /// - Parameter elementID: The ID of the element to select.
    func select(_ elementID: String) {
        print("\(#function)ing...")
        //TODO: - select()
    }
    
    /// Updates the selected node based on the provided direction.
    /// - Parameter direction: The direction to move in (left, up, down, right).
    func updateSelectedNode(_ direction: Direction?) {
        
    }
}


// MARK: - UIStyleSheetNodeDelegate

extension UIStyleSheet: UIStyleSheetNodeDelegate {
    /// Handles node selection by delegating to the `select` method.
    /// - Parameter nodeID: The ID of the node to select.
    func select(nodeID: String) {
        print("\(#function)ing...")
        //TODO: - select(nodeID: String)
    }
    
    /// Handles node deletion by delegating to the `delete` method and notifying the delegate.
    /// - Parameter nodeID: The ID of the node to delete.
    func delete(nodeID: String) {
        print("\(#function)ing...")
        //TODO: - delete(nodeID: String)
    }
    
}
