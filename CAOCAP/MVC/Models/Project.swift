//
//  Project.swift
//  CAOCAP
//
//  Created by Azzam AL-Rashed on 17/07/2023.
//
/*
 refactor goal: to make this class easer to understand and update
 
 */

import UIKit
import SwiftSoup

struct ProjectState {
    var document: String
    var selectedElementID: String
}

class Project {
    
    var document: Document?
    var selectedElementID: String?
    var undos = [ProjectState]()
    var redos = [ProjectState]()
    
    init() {
        do {
            selectedElementID = AppConstants.bodyID
            document = try SwiftSoup.parse(AppConstants.html)
        } catch Exception.Error(let type, let message) {
            print(type, message)
        } catch {
            print("error")
        }
        
    }
    
    init(document: Document, undos: [ProjectState] = [], redos: [ProjectState] = [], selectedElementID: String? = nil) {
        self.document = document
        self.undos = undos
        self.redos = redos
        self.selectedElementID = selectedElementID
    }
    
    func getOuterHtml() -> String? {
        do {
            return try document?.outerHtml()
        } catch Exception.Error(let type, let message) {
            print(type, message)
        } catch {
            print("error")
        }
        return nil
    }
    
    func getDocumentLang() -> String? {
        do {
            return try document?.getElementsByTag("html").attr("lang")
        } catch Exception.Error(let type, let message) {
            print(type, message)
        } catch {
            print("error")
        }
        return nil
    }
    
    func setDocumentLang(_ code: String) {
        do {
            try document?.getElementsByTag("html").attr("lang", code)
        } catch Exception.Error(let type, let message) {
            print(type, message)
        } catch {
            print("error")
        }
    }
    
    func getDocumentTitle() -> String? {
        do {
            return try document?.head()?.getElementsByTag("title").first()?.text()
        } catch Exception.Error(let type, let message) {
            print(type, message)
        } catch {
            print("error")
        }
        return nil
    }
    
    func setDocumentTitle(_ title: String) {
        do {
            try document?.head()?.getElementsByTag("title").first()?.text(title)
        } catch Exception.Error(let type, let message) {
            print(type, message)
        } catch {
            print("error")
        }
    }
    
    func saveToUndos() { //TODO: change function name
        if let currentDoc = getOuterHtml(),
            let id = selectedElementID {
            redos.removeAll()
            undos.append(ProjectState(document: currentDoc, selectedElementID: id))
        }
    }
    
    func undo() {
        guard !undos.isEmpty else { return }
        if let currentDoc = getOuterHtml(),
            let id = selectedElementID {
            redos.append(ProjectState(document: currentDoc, selectedElementID: id))
            do {
                let undone = undos.removeLast()
                document = try SwiftSoup.parse(undone.document)
                selectedElementID = undone.selectedElementID
            } catch Exception.Error(let type, let message) {
                print(type, message)
            } catch {
                print("error")
            }
        }
    }
    
    func redo() {
        guard !redos.isEmpty else { return }
        if let currentDoc = getOuterHtml(),
           let id = selectedElementID {
            undos.append(ProjectState(document: currentDoc, selectedElementID: id))
            do {
                let redone = redos.removeLast()
                document = try SwiftSoup.parse(redone.document)
                selectedElementID = redone.selectedElementID
            } catch Exception.Error(let type, let message) {
                print(type, message)
            } catch {
                print("error")
            }
        }
    }
    
    func getSelectedElement() -> Element? {
        if let selectedElementID = selectedElementID {
            do {
                return try document?.body()?.getElementById(selectedElementID)
            } catch Exception.Error(let type, let message) {
                print(type, message)
            } catch {
                print("error")
            }
        }
        return nil
    }
    
    func setSelectedElementText(content: String) {
        guard let element = getSelectedElement() else { return }
        do {
            if let textNode = element.textNodes().first {
                // if the element has a text node, update its value
                textNode.text(content)
            } else {
                // if it don't have a text node, create one at the beginning
                try element.prependText(content)
            }
        } catch Exception.Error(let type, let message) {
            print(type, message)
        } catch {
            print("error")
        }
    }
    
    func toggleSelectedElement(className: String) {
        guard let element = getSelectedElement() else { return }
        do {
            try element.toggleClass(className)
        } catch Exception.Error(let type, let message) {
            print(type, message)
        } catch {
            print("error")
        }
    }
    
    func getSelectedElementTextDecorations() -> [TextDecoration]? {
        guard let element = getSelectedElement() else { return nil }
        var result = [TextDecoration]()
        for decoration in TextDecoration.allCases {
            if element.hasClass(decoration.rawValue) {
                result.append(decoration) // 🤔 why not try .filter()
            }
        }
        return result
    }
    
    func toggleSelectedElementText(decoration: TextDecoration) {
        toggleSelectedElement(className: decoration.rawValue)
    }
    
    func getSelectedElementTextAlignment() -> String? {
        guard let element = getSelectedElement() else { return nil }
        for textAlign in TailwindCSS.textAlign {
            if element.hasClass(textAlign) {
                return textAlign
            }
        }
        return nil
    }
    
    func setSelectedElementText(alignment: String) {
        guard let element = getSelectedElement() else { return }
        do {
            if let previousAlignment = getSelectedElementTextAlignment() {
                try element.removeClass(previousAlignment)
            }
            
            try element.addClass(alignment)
        } catch Exception.Error(let type, let message) {
            print(type, message)
        } catch {
            print("error")
        }
    }
    
    func getSelectedElementSemantic() -> String? {
        //TODO: get the selected element Semantic (tag name)
        return ""
    }
    
    func setSelectedElement(semantic: String) {
        //TODO: set the selected element Semantic (tag name)
    }
    
    func getSelectedElementType() -> String? {
        do {
            return try getSelectedElement()?.attr("type")
        } catch Exception.Error(let type, let message) {
            print(type, message)
        } catch {
            print("error")
        }
        return nil
    }
    
    func setSelectedElement(type: String) {
        do {
            try getSelectedElement()?.attr("type", type)
        } catch Exception.Error(let type, let message) {
            print(type, message)
        } catch {
            print("error")
        }
    }
    
    func getSelectedElementListStyle() -> String? {
        //TODO: get the selected element Semantic (tag name)
        return ""
    }
    
    func setSelectedElement(listStyle: String) {
        //TODO: get the selected element Semantic (tag name)
    }
    
    func getSelectedElementSource() -> String? {
        do {
            return try getSelectedElement()?.attr("src")
        } catch Exception.Error(let type, let message) {
            print(type, message)
        } catch {
            print("error")
        }
        return nil
    }
    
    func setSelectedElement(source: String) {
        do {
            try getSelectedElement()?.attr("src", source)
        } catch Exception.Error(let type, let message) {
            print(type, message)
        } catch {
            print("error")
        }
    }
    
    
    func isSelectedElementHidden() -> Bool {
         return getSelectedElement()?.hasAttr("hidden") ?? false
    }
    
    func setSelectedElementHidden(_ isHidden: Bool) {
        do {
            if isHidden {
                try getSelectedElement()?.attr("hidden", "")
            } else {
                try getSelectedElement()?.removeAttr("hidden")
            }
        } catch Exception.Error(let type, let message) {
            print(type, message)
        } catch {
            print("error")
        }
    }
    
    func getSelectedElementBackgroundColor() -> String? {
        guard let element = getSelectedElement() else { return nil }
        do {
            let classNames = try element.classNames()
            for className in classNames { // is there a better way 🤔
                if className.contains("bg-[") || TailwindCSS.backgroundColor.contains(className) {
                    return className
                }
            }
        } catch Exception.Error(let type, let message) {
            print(type, message)
        } catch {
            print("error")
        }
        
        return nil
    }
    
    func setSelectedElementBackground(color: UIColor) {
        guard let element = getSelectedElement() else { return }
        do {
            if let previousColor = getSelectedElementBackgroundColor() {
                try element.removeClass(previousColor)
            }
            
            try element.addClass("bg-[\(color.hexString)]") 
        } catch Exception.Error(let type, let message) {
            print(type, message)
        } catch {
            print("error")
        }
    }
    
    func getSelectedElementTextColor() -> String? {
        guard let element = getSelectedElement() else { return nil }
        do {
            let classNames = try element.classNames()
            for className in classNames { // is there a better way 🤔
                if className.contains("text-[") || TailwindCSS.textColor.contains(className) {
                    return className
                }
            }
        } catch Exception.Error(let type, let message) {
            print(type, message)
        } catch {
            print("error")
        }
        
        return nil
    }
    
    func setSelectedElementText(color: UIColor) {
        guard let element = getSelectedElement() else { return }
        do {
            if let previousColor = getSelectedElementTextColor() {
                try element.removeClass(previousColor)
            }
            
            try element.addClass("text-[\(color.hexString)]")
        } catch Exception.Error(let type, let message) {
            print(type, message)
        } catch {
            print("error")
        }
    }
}
