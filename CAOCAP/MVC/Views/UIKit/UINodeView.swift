//
//  UINodeView.swift
//  CAOCAP
//
//  Created by Azzam AL-Rashed on 21/06/2023.
//

import UIKit
import SwiftSoup

protocol UINodeViewDelegate {
    func select(nodeID: String)
    func delete(nodeID: String)
}

class UINodeView: UIView, UIContextMenuInteractionDelegate {
    let element: Element
    var delegate: UINodeViewDelegate?
    init(element: Element) {
        self.element = element
        let tagName = element.tagName()
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 60).isActive = true  //TODO: use SnapKit
        widthAnchor.constraint(equalToConstant: 150).isActive = true  //TODO: use SnapKit
        layer.cornerRadius = 10
        layer.borderColor = UIColor.purple.cgColor
        setBackgroundColor(tagName: tagName)
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 150, height: 60))
        label.textAlignment = .center
        label.text = tagName
        label.textColor = .white
        label.font = UIFont.ubuntu(.medium, size: 20)
        addSubview(label)
        
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTap(gesture:))))
        addInteraction(UIContextMenuInteraction(delegate: self))
    }
    
    func setBackgroundColor(tagName: String) {
        switch tagName {
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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func didTap(gesture: UITapGestureRecognizer) {
        let id = element.id()
        print("did tap node:\(id)")
        delegate?.select(nodeID: id)
    }
    
    func delete() {
        DispatchQueue.main.async {
            self.removeFromSuperview()
        }
    }
    
    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(actionProvider:  { _ in
            guard self.element.tagName() != "body" else { return nil }
            return UIMenu(options: [.displayInline], children: [UIAction(title: "Remove", attributes: .destructive, handler: { _ in
                self.delegate?.delete(nodeID: self.element.id())
            })])
            
        })
    }
    
    
    //MARK: - Stolen from https://kylebashour.com/posts/context-menu-guide
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
