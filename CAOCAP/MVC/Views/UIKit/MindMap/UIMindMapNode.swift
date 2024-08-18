//
//  UIMindMapNode.swift
//  CAOCAP
//
//  Created by Azzam AL-Rashed on 21/06/2023.
//

import UIKit
import SwiftSoup

/// Protocol for handling node view interactions.
protocol UIMindMapNodeDelegate {
    /// Called when a node is selected. The delegate should update the UI or handle the selection.
    func select(nodeID: String)
    
    /// Called when a node is to be deleted. The delegate should manage node removal.
    func delete(nodeID: String)
}

/// A view for displaying a node in the mind map, with support for context menus.
class UIMindMapNode: UIView, UIContextMenuInteractionDelegate {
    
    let element: Element
    var delegate: UIMindMapNodeDelegate?
    
    /// Initializes the view with the specified HTML element.
    ///
    /// - Parameter element: The HTML element represented by this view.
    init(element: Element) {
        self.element = element
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        setupConstraints()
        layer.cornerRadius = 10
        layer.borderColor = UIColor.purple.cgColor
        setBackgroundColor()
        setupLabel()
        setupGestures()
    }
    
    private func setupConstraints() {
        snp.makeConstraints { make in
            make.height.equalTo(60)
            make.width.equalTo(150)
        }
    }
    
    
    private func setupLabel() {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 150, height: 60))
        label.textAlignment = .center
        label.text = element.tagName()
        label.textColor = .white
        label.font = UIFont.ubuntu(.medium, size: 20)
        addSubview(label)
    }
    
    private func setupGestures() {
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTap)))
        addInteraction(UIContextMenuInteraction(delegate: self))
    }
    
    private func setBackgroundColor() {
        switch element.tagName() {
        case "body":
            backgroundColor = .systemBlue
        case "span","canvas","div","header","main","footer","article","section","aside","nav":
            backgroundColor = .systemGreen
        case "button","a","input":
            backgroundColor = .systemPurple
        case "textArea","form","label","option","legend","select","fieldSet","optGroup","output":
            backgroundColor = .systemTeal
        case "video","img","audio":
            backgroundColor = .systemYellow
        case "li","h1","p":
            backgroundColor = .systemGray3
        case "ul","ol","br","hr":
            backgroundColor = .systemGray
        default:
            backgroundColor = .systemGray2
        }
    }
    
    /// Handles tap gestures to select the node.
    @objc func didTap(gesture: UITapGestureRecognizer) {
        print("did tap node:\(element.id())")
        delegate?.select(nodeID: element.id())
    }
    
    /// Removes the view from its superview.
    func delete() {
        DispatchQueue.main.async {
            self.removeFromSuperview()
        }
    }
    
    // MARK: - Context Menu Interaction
    
    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(actionProvider:  { _ in
            guard self.element.tagName() != "body" else { return nil }
            return UIMenu(options: [.displayInline], children: [UIAction(title: "Remove", attributes: .destructive, handler: { _ in
                self.delegate?.delete(nodeID: self.element.id())
            })])
            
        })
    }
    
    // MARK: - Context Menu Preview
    /// https://kylebashour.com/posts/context-menu-guide
    // improved UI behaviour
    private func makeTargetedPreview(for configuration: UIContextMenuConfiguration) -> UITargetedPreview? {
        let visiblePath = UIBezierPath(roundedRect: bounds, cornerRadius: 16)
        let parameters = UIPreviewParameters()
        parameters.visiblePath = visiblePath
        parameters.backgroundColor = .clear
        return UITargetedPreview(view: self, parameters: parameters)
    }
    
    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, previewForHighlightingMenuWithConfiguration configuration: UIContextMenuConfiguration) -> UITargetedPreview? {
        return makeTargetedPreview(for: configuration)
    }
    
    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, previewForDismissingMenuWithConfiguration configuration: UIContextMenuConfiguration) -> UITargetedPreview? {
        return makeTargetedPreview(for: configuration)
    }
}
