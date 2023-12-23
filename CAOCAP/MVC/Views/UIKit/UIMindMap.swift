//
//  UIMindMap.swift
//  CAOCAP
//
//  Created by Azzam AL-Rashed on 07/06/2023.
//

import UIKit
import SnapKit
import SwiftSoup

protocol UIMindMapDelegate {
    func didRemoveNode()
}

class UIMindMap: UIScrollView, UIScrollViewDelegate {
    
    var project: Project?
    
    var nodeTree = [String: UINodeView]()
    
    var mindMapDelegate: UIMindMapDelegate?
    var canvasHeightConstraint = NSLayoutConstraint()
    var canvasWidthConstraint = NSLayoutConstraint()
    
    let canvas: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.backgroundColor = UIColor(patternImage: UIImage(named: "dot")!)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        delegate = self
        translatesAutoresizingMaskIntoConstraints = false
        minimumZoomScale = 0.3
        maximumZoomScale = 3.0
        zoomScale = 0.5
        addSubview(canvas)
        canvasHeightConstraint = canvas.heightAnchor.constraint(equalToConstant: frame.height + 200) //TODO: use SnapKit
        canvasWidthConstraint = canvas.widthAnchor.constraint(equalToConstant: frame.width + 200 ) //TODO: use SnapKit
        canvasHeightConstraint.isActive = true
        canvasWidthConstraint.isActive = true
        canvas.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        contentInset = UIEdgeInsets(top: 200, left: 100, bottom: 200 , right: 100)
        contentOffset = CGPoint(x: -50, y: -150)
        layoutIfNeeded()
        canvas.addGestureRecognizer(doubleTapZoom)
        canvas.isUserInteractionEnabled = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func loadBody() {
        print("\(#function)ing...")
        guard let body = project?.document?.body() else { return }
        canvas.subviews.forEach({ $0.removeFromSuperview() })
        draw(body)
        if !body.children().isEmpty() { load(children: body.children()) }
    }
    
    func load(children: Elements) {
        print("\(#function)ing...")
        children.forEach { child in
            draw(child)
            if !child.children().isEmpty() { load(children: child.children()) }
        }
        
    }
    
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
        select(newElement.id())/*🤔*/
    }
    
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
        select(parent.id())/*🤔*/
    }
    
    func draw(_ element: Element) {
        print("\(#function)ing... \(element.tagName())")
        let nodeView = UINodeView(element: element)
        nodeTree[element.id()] = nodeView
        nodeView.delegate = self
        canvas.addSubview(nodeView)
        
        canvasWidthConstraint.constant += 30/*🤔*/
        canvasHeightConstraint.constant += 30/*🤔*/
        
        if element.tagName() == "body" {
            nodeView.centerXAnchor.constraint(equalTo: canvas.centerXAnchor).isActive = true  //TODO: use SnapKit
            nodeView.centerYAnchor.constraint(equalTo: canvas.centerYAnchor).isActive = true  //TODO: use SnapKit
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
                        nodeView.centerXAnchor.constraint(equalTo: parentView.centerXAnchor, constant: 90).isActive = true  //TODO: use SnapKit
                    } else if elementSiblingIndex == centerPosition - 1 {
                        //near centre left child
                        nodeView.centerXAnchor.constraint(equalTo: parentView.centerXAnchor, constant: -90).isActive = true  //TODO: use SnapKit
                    } else {
                        //push to the right or left| i am 0 of 4 -> 0 - 2 + 0.5 -> -1.5*180, i am 3 of 4 -> 3 - 2 + 0.5 -> 1.5*180
                        let multiplier = Double(element.siblingIndex - centerPosition) + 0.5
                        nodeView.centerXAnchor.constraint(equalTo: parentView.centerXAnchor, constant: CGFloat(multiplier * 180)).isActive = true  //TODO: use SnapKit
                    }
                } else {
                    // odd number of children ( one centered child )
                    if elementSiblingIndex == centerPosition {
                        //centered child
                        nodeView.centerXAnchor.constraint(equalTo: parentView.centerXAnchor).isActive = true  //TODO: use SnapKit
                    } else {
                        //push to the right or left
                        let multiplier = elementSiblingIndex - centerPosition
                        nodeView.centerXAnchor.constraint(equalTo: parentView.centerXAnchor, constant: CGFloat(multiplier * 180)).isActive = true  //TODO: use SnapKit
                    }
                }
            } catch Exception.Error(let type, let message) {
                print(type, message)
            } catch {
                print("error")
            }
            nodeView.centerYAnchor.constraint(equalTo: parentView.centerYAnchor, constant: 120).isActive = true  //TODO: use SnapKit
        }
        
        if !element.children().isEmpty() {
            let nodeStroke = UIStroke(lines: element.children().count)
            canvas.insertSubview(nodeStroke, at: 0)
            nodeStroke.widthConstraint.constant = CGFloat(element.children().count * 180)  //TODO: use SnapKit
            nodeStroke.centerXAnchor.constraint(equalTo: nodeView.centerXAnchor).isActive = true  //TODO: use SnapKit
            nodeStroke.topAnchor.constraint(equalTo: nodeView.bottomAnchor).isActive = true  //TODO: use SnapKit
        }
    }
    
    func select(_ elementID: String) {
        guard let previouslySelectedID = project?.selectedElementID else { return }
        
        print("Previously Selected Node ID: \(previouslySelectedID)")
        ReduxStore.dispatch(UpdateSelectedElementAction(selectedID: elementID))
        print("Current Selected Node ID: \(elementID)")

        if let selectedNodeView = nodeTree[elementID] {
            selectedNodeView.layer.borderWidth = 2
        }
        if let previousNodeView = nodeTree[previouslySelectedID] {
            previousNodeView.layer.borderWidth = 0
        }
    }
    
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
    
    func center() {
        print("\(#function)ing...")
        let centerOffsetX = (contentSize.width - frame.size.width) / 2
        let centerOffsetY = (contentSize.height - frame.size.height) / 2
        let centerPoint = CGPoint(x: centerOffsetX, y: centerOffsetY)
        setContentOffset(centerPoint, animated: true)
        /*🤔 🤔 🤔*/
    }
    
    //MARK: - handle Zooming in/out
    lazy var doubleTapZoom: UITapGestureRecognizer = {
        let zoomingTap = UITapGestureRecognizer(target: self, action: #selector(handleZoomingTap))
        zoomingTap.numberOfTapsRequired = 2
        return zoomingTap
    }()
    @objc func handleZoomingTap(sender: UITapGestureRecognizer) {
        let location = sender.location(in: sender.view)
        zoom(to: zoomRect(scale: zoomScale == minimumZoomScale ? maximumZoomScale : minimumZoomScale, center: location), animated: true)
    }
    func zoomRect(scale: CGFloat, center: CGPoint) -> CGRect {
        var zoomRect = CGRect.zero
        zoomRect.size.height = canvasHeightConstraint.constant / scale
        zoomRect.size.width = canvasWidthConstraint.constant / scale
        zoomRect.origin.x = center.x - (zoomRect.size.width / 2)
        zoomRect.origin.y = center.y - (zoomRect.size.height / 2)
        return zoomRect
    }
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return canvas
    }
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        /* center() 🤔 🤔 🤔*/
    }
}


extension UIMindMap: UINodeViewDelegate {
    func select(nodeID: String) {
        print("\(#function)ing...")
        select(nodeID)
    }
    
    func delete(nodeID: String) {
        print("\(#function)ing...")
        guard let body = project?.document?.body() else { return }
        do {
            if let element = try body.getElementById(nodeID) {
                DispatchQueue.main.async {
                    self.delete(element)
                    self.mindMapDelegate?.didRemoveNode()
                }
            }
        } catch Exception.Error(let type, let message) {
            print(type, message)
        } catch {
            print("error")
        }
    }
    
}


