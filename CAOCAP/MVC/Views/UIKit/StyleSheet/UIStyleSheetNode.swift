//
//  UIStyleSheetNode.swift
//  CAOCAP
//
//  Created by الشيخ عزام on 11/08/2024.
//

import UIKit


/// Protocol for handling node view interactions.
protocol UIStyleSheetNodeDelegate {
    /// Called when a node is selected. The delegate should update the UI or handle the selection.
    func select(nodeID: String)
    
    /// Called when a node is to be deleted. The delegate should manage node removal.
    func delete(nodeID: String)
}


class UIStyleSheetNode: UIView, UIContextMenuInteractionDelegate {
    // TODO: - UIStyleSheetNode
    
    // Properties for the node type and the label displaying the type description
    var delegate: UIStyleSheetNodeDelegate?
    private var label: UILabel!
    
    /// Initializes the view with the specified CSS element.
    ///
    /// - Parameter element: The CSS element represented by this view.
    init() {
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
        backgroundColor = .systemPurple
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
        label.text = "root"
        label.textColor = .white
        label.font = UIFont.ubuntu(.medium, size: 20)
        addSubview(label)
    }
    
    private func setupGestures() {
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTap)))
        addInteraction(UIContextMenuInteraction(delegate: self))
    }
    
    /// Handles tap gestures to select the node.
    @objc func didTap(gesture: UITapGestureRecognizer) {
        print("did tap node:")
        // TODO: - didTap(gesture: UITapGestureRecognizer)
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
            return UIMenu(options: [.displayInline], children: [UIAction(title: "Remove", attributes: .destructive, handler: { _ in
                // TODO: - this should use the ID of the node
                self.delegate?.delete(nodeID: "Root")
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
