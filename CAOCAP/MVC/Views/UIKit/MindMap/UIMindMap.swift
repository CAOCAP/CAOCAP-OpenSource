//
//  UIMindMap.swift
//  CAOCAP
//
//  Created by Azzam AL-Rashed on 07/06/2023.
//

import UIKit
import SnapKit
import SwiftSoup

/// A protocol for handling events related to the mind map.
protocol UIMindMapDelegate {
    /// Called when a node is removed from the mind map.
    func didRemoveMindMapNode()
}

/// A custom view for displaying and managing a mind map on a canvas.
class UIMindMap: UICanvas {
    
    // MARK: - Properties
    var project: Project?
    var nodeTree = [String: UIMindMapNode]()
    var mindMapDelegate: UIMindMapDelegate?
    
    // MARK: - Load and Display Elements
    
    /// Loads and displays the HTML body element of the project's document on the canvas.
    func loadBody() {
        print("\(#function)ing...")
        guard let body = project?.document?.body() else { return }
        clearCanvas()
        draw(body)
        if !body.children().isEmpty() { load(children: body.children()) }
    }
    
    /// Recursively loads and displays the children of the given element.
    /// - Parameter children: The children elements to load and display.
    func load(children: Elements) {
        print("\(#function)ing...")
        children.forEach { child in
            draw(child)
            if !child.children().isEmpty() { load(children: child.children()) }
        }
    }
    
    // MARK: - Draw Elements
    
    /// Draws a node for the given element and adds it to the canvas.
    /// - Parameter element: The element to draw on the canvas.
    func draw(_ element: Element) {
        print("\(#function)ing... \(element.tagName())")
        let nodeView = UIMindMapNode(element: element)
        nodeTree[element.id()] = nodeView
        nodeView.delegate = self
        canvas.addSubview(nodeView)
        setNodePosition(nodeView)
        drawNodeStrokes(nodeView)
        expandCanvasIfNeeded()
    }
    
    /// Sets the position constraints for a node view on the canvas.
    /// - Parameter nodeView: The node view to position.
    func setNodePosition(_ nodeView: UIMindMapNode) {
        let element = nodeView.element
        if element.tagName() == "body" {
            nodeView.snp.makeConstraints {
                $0.centerX.equalToSuperview()
                $0.top.equalToSuperview().offset(400)
            }
        } else {
            guard let parent = element.parent(), let parentView = nodeTree[parent.id()] else { return }
            do {
                let elementSiblingIndex = try element.elementSiblingIndex()
                //set nodeView constraints
                let centerPosition = Int(parent.children().count/2)
                if parent.children().count % 2 == 0 {
                    // even number of children ( two near centre children )
                    if elementSiblingIndex == centerPosition {
                        //near centre right child
                        nodeView.snp.makeConstraints { $0.centerX.equalTo(parentView.snp.centerX).offset(90)}
                    } else if elementSiblingIndex == centerPosition - 1 {
                        //near centre left child
                        nodeView.snp.makeConstraints { $0.centerX.equalTo(parentView.snp.centerX).offset(-90)}
                    } else {
                        //push to the right or left|
                        //i'm index 0 of 6 -> 0 - 3 + 0.5-> -2.5*180 = -450,
                        //i'm index 1 of 6 -> 1 - 3 -> -1.5*180 = -270
                        // ---------two near centre children-----------
                        //i'm index 4 of 6 -> 4 - 3 + 0.5 -> 1.5*180 = 270,
                        //i'm index 5 of 6 -> 5 - 3 + 0.5 -> 2.5*180 = 450
                        let multiplier = Double(elementSiblingIndex - centerPosition) + 0.5
                        nodeView.snp.makeConstraints { $0.centerX.equalTo(parentView.snp.centerX).offset(180 * multiplier)}
                    }
                } else {
                    // odd number of children ( one centered child )
                    if elementSiblingIndex == centerPosition {
                        //centered child
                        nodeView.snp.makeConstraints { $0.centerX.equalTo(parentView.snp.centerX) }
                    } else {
                        //push to the right or left
                        let multiplier = elementSiblingIndex - centerPosition
                        nodeView.snp.makeConstraints { $0.centerX.equalTo(parentView.snp.centerX).offset(180 * multiplier) }
                    }
                }
            } catch Exception.Error(let type, let message) {
                print(type, message)
            } catch {
                print("error")
            }
            nodeView.snp.makeConstraints { $0.centerY.equalTo(parentView).offset(120)}
        }
        
    }
    
    /// Draws connection strokes between nodes on the canvas.
    /// - Parameter nodeView: The node view for which to draw strokes.
    func drawNodeStrokes(_ nodeView: UIMindMapNode) {
        let countChildren = nodeView.element.children().count
        if countChildren > 0 {
            let nodeStroke = UIMindMapStroke(lines: countChildren)
            canvas.insertSubview(nodeStroke, at: 0)
            nodeStroke.widthConstraint.constant = CGFloat(countChildren * 180)
            nodeStroke.snp.makeConstraints { make in
                make.centerX.equalTo(nodeView.snp.centerX)
                make.top.equalTo(nodeView.snp.bottom)
            }
        }
    }
    
    // MARK: - Add, Delete, and Select Nodes
    
    /// Adds a new node with the specified tag to the mind map.
    /// - Parameter tag: The tag for the new node.
    func add(tag: String) {
        print("\(#function)ing...")
        ReduxStore.dispatch(WillEditAction())
        guard let body = project?.document?.body(),
              let selectedID = project?.selectedElementID
        else { return }
        
        let newElement = Element(Tag(tag), "")
        do {
            try newElement.attr("id", UUID().uuidString)
            let selectedNode = try body.getElementById(selectedID)
            try selectedNode?.appendChild(newElement)
        } catch Exception.Error(let type, let message) {
            print(type, message)
        } catch {
            print("error")
        }
        select(newElement.id())
    }
    
    /// Deletes the specified element from the mind map.
    /// - Parameter element: The element to delete.
    func delete(_ element: Element) {
        print("\(#function)ing...")
        ReduxStore.dispatch(WillEditAction())
        guard let parent = element.parent() else { return }
        do {
            try parent.removeChild(element)
        } catch Exception.Error(let type, let message) {
            print(type, message)
        } catch {
            print("error")
        }
        select(parent.id())
    }
    
    /// Selects a node by its ID and zooms to it.
    /// - Parameter elementID: The ID of the element to select.
    func select(_ elementID: String) {
        guard let previouslySelectedID = project?.selectedElementID else { return }
        print("Previously Selected Node ID: \(previouslySelectedID)")
        ReduxStore.dispatch(UpdateSelectedElementAction(selectedID: elementID))
        print("Current Selected Node ID: \(elementID)")
        if let selectedNodeView = nodeTree[elementID] {
            selectedNodeView.layer.borderWidth = 2
            zoom(to: zoomRect(scale: 1.5, center: CGPoint(x: selectedNodeView.frame.midX, y: selectedNodeView.frame.midY)), animated: true)
            
        }
        if let previousNodeView = nodeTree[previouslySelectedID] {
            previousNodeView.layer.borderWidth = 0
        }
    }
    
    /// Updates the selected node based on the provided direction.
    /// - Parameter direction: The direction to move in (left, up, down, right).
    func updateSelectedNode(_ direction: Direction?) {
        guard let direction = direction,
              let body = project?.document?.body(),
              let selectedID = project?.selectedElementID
        else { return }
        
        do {
            if let element = try body.getElementById(selectedID) {
                switch direction {
                case .left:
                    guard let previousSibling = try element.previousElementSibling() else { return }
                    print("select prevues sibling")
                    select(previousSibling.id())
                case .up:
                    guard let parent = element.parent() else { return }
                    print("select parent")
                    select(parent.id())
                case .down:
                    guard let firstChild = element.children().first() else { return }
                    print("select first child")
                    select(firstChild.id())
                case .right:
                    guard let nextSibling = try element.nextElementSibling() else { return }
                    print("select next sibling")
                    select(nextSibling.id())
                }
            }
        } catch Exception.Error(let type, let message) {
            print(type, message)
        } catch {
            print("error")
        }
    }
    
}

// MARK: - UIMindMapNodeDelegate

extension UIMindMap: UIMindMapNodeDelegate {
    /// Handles node selection by delegating to the `select` method.
    /// - Parameter nodeID: The ID of the node to select.
    func select(nodeID: String) {
        print("\(#function)ing...")
        select(nodeID)
    }
    
    /// Handles node deletion by delegating to the `delete` method and notifying the delegate.
    /// - Parameter nodeID: The ID of the node to delete.
    func delete(nodeID: String) {
        print("\(#function)ing...")
        guard let body = project?.document?.body() else { return }
        do {
            if let element = try body.getElementById(nodeID) {
                DispatchQueue.main.async {
                    self.delete(element)
                    self.mindMapDelegate?.didRemoveMindMapNode()
                }
            }
        } catch Exception.Error(let type, let message) {
            print(type, message)
        } catch {
            print("error")
        }
    }
    
}


