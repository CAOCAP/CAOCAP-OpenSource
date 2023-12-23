//
//  MindMapVC.swift
//  CAOCAP
//
//  Created by Azzam AL-Rashed on 03/06/2023.
//

import UIKit
import WebKit
import ReSwift
import SnapKit
import SwiftSoup

class MindMapVC: UIViewController, Storyboarded {
    
    var project: Project?
    var completeChallenges: [String]?
    var tailwindClassNames = TailwindCSS.all
    
    @IBOutlet weak var projectTitle: UILabel!
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var resizeIcon: UIImageView!
    @IBOutlet weak var webViewWidthConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var undoButton: UIButton!
    @IBOutlet weak var redoButton: UIButton!
    
    @IBOutlet weak var toolsView: UIView!
    @IBOutlet weak var toolsViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var htmlView: UIView!
    @IBOutlet weak var htmlKeyboard: UIStackView!
    
    @IBOutlet weak var attributesView: UIView!
    @IBOutlet weak var attributesStackView: UIStackView!
    @IBOutlet weak var attributesSegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var contentTextField: UITextField!
    @IBOutlet var textDecorationButtons: [UIButton]!
    @IBOutlet weak var textAlignmentSegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var typeButton: UIButton!
    @IBOutlet weak var semanticButton: UIButton!
    @IBOutlet weak var listStyleButton: UIButton!
    
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var sourceTextField: UITextField!
    @IBOutlet weak var backgroundColorWell: UIColorWell!
    @IBOutlet weak var textColorWell: UIColorWell!
    @IBOutlet weak var hiddenSwitch: UISwitch!
    @IBOutlet weak var tailwindCollectionView: UICollectionView!
    
    @IBOutlet weak var jsView: UIView!
    
    var mindMap: UIMindMap!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let resizeGR = UIPanGestureRecognizer(target: self, action: #selector(handleResizingWebView(sender:)))
        resizeIcon.addGestureRecognizer(resizeGR)
        contentTextField.isFirstResponder
        
        setupToolsViewGestureRecognizer()
        setupMindMapLayout()
        setupMenuButtons()
    }
    
    func loadWebView() {
        guard let document = project?.document else { return }
        do {
            let htmlCode = try document.outerHtml()
            print("loadWebView:", htmlCode)
            webView.loadHTMLString( htmlCode, baseURL: nil)
        } catch Exception.Error(let type, let message) {
            print(type, message)
        } catch {
            print("error")
        }
    }
    
    
    func setupMindMapLayout() {
        mindMap = UIMindMap(frame: view.frame)
        mindMap.mindMapDelegate = self
        view.insertSubview(mindMap, at: 0)
        mindMap.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func setupToolsViewGestureRecognizer() {
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleKeyboardSwipe(sender:)))
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleKeyboardSwipe(sender:)))
        let upSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleKeyboardSwipe(sender:)))
        let downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleKeyboardSwipe(sender:)))
        rightSwipe.direction = .right
        leftSwipe.direction = .left
        upSwipe.direction = .up
        downSwipe.direction = .down
        toolsView.addGestureRecognizer(rightSwipe)
        toolsView.addGestureRecognizer(leftSwipe)
        toolsView.addGestureRecognizer(upSwipe)
        toolsView.addGestureRecognizer(downSwipe)
    }
    
    func setupMenuButtons() {
        //TODO: clean/refactor /replace with popovers menu 🛠️
        var typeArray = [
            UIAction(title: "type 1", state: .on, handler: { print($0.title) }),
            UIAction(title: "type 2", state: .off, handler: { print($0.title) }),
            UIAction(title: "type 3", state: .off, handler: { print($0.title) }),
        ]
        
        var semanticArray = [
            UIAction(title: "semantic 1", state: .on, handler: { print($0.title) }),
            UIAction(title: "semantic 2", state: .off, handler: { print($0.title) }),
            UIAction(title: "semantic 3", state: .off, handler: { print($0.title) }),
        ]
        
        var listStyleArray = [
            UIAction(title: "none", state: .on, handler: { print($0.title) }),
            UIAction(title: "disc", state: .off, handler: { print($0.title) }),
            UIAction(title: "decimal", state: .off, handler: { print($0.title) }),
        ]
        
        typeButton.menu = UIMenu(title: "", options: .displayInline, children: typeArray)
        semanticButton.menu = UIMenu(title: "", options: .displayInline, children: semanticArray)
        listStyleButton.menu = UIMenu(title: "", options: .displayInline, children: listStyleArray)
    }
    
    @objc func handleResizingWebView(sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .began, .changed:
            let touchPoint = sender.location(in: view).x - 20
            if touchPoint > 60 && touchPoint < 240 {
                webViewWidthConstraint.constant =
                touchPoint
            }
        default:
            if webViewWidthConstraint.constant < 90 {
                webViewWidthConstraint.constant = 80
            } else if webViewWidthConstraint.constant >= 90 && webViewWidthConstraint.constant < 130 {
                webViewWidthConstraint.constant = 120
            } else if webViewWidthConstraint.constant >= 130 && webViewWidthConstraint.constant < 170 {
                webViewWidthConstraint.constant = 160
            } else {
                webViewWidthConstraint.constant = 200
            }
        }
    }
    
    
    @objc func handleKeyboardSwipe(sender: UISwipeGestureRecognizer) {
        if sender.state == .ended {
            switch sender.direction {
            case .right, .left:
                if !htmlView.isHidden {
                    htmlView.isHidden = true
                    attributesView.isHidden = false
                } else {
                    attributesView.isHidden = true
                    htmlView.isHidden = false
                }
            case .up:
                if toolsViewHeightConstraint.constant == 40 {
                    //only show 6,7 { h=107 }
                    toolsViewHeightConstraint.constant = 107
                    for n in 6...7 {
                        let view = htmlKeyboard.arrangedSubviews[n]
                        view.alpha = 1
                        view.isHidden = false
                    }
                } else if toolsViewHeightConstraint.constant == 107 {
                    //show all but not 3,4 { h=255 }
                    toolsViewHeightConstraint.constant = 255
                    for n in 0...5 {
                        if [3,4].contains(n) { continue }
                        let view = htmlKeyboard.arrangedSubviews[n]
                        view.alpha = 1
                        view.isHidden = false
                    }
                } else if toolsViewHeightConstraint.constant == 255 {
                    //show all { h=329 }
                    webViewWidthConstraint.constant = 120
                    toolsViewHeightConstraint.constant = 329
                    for n in 3...4 {
                        let view = htmlKeyboard.arrangedSubviews[n]
                        view.alpha = 1
                        view.isHidden = false
                    }
                }
            case .down:
                if toolsViewHeightConstraint.constant == 107 {
                    //hide all { h=40 }
                    toolsViewHeightConstraint.constant = 40
                    for n in 6...7 {
                        let view = htmlKeyboard.arrangedSubviews[n]
                        view.alpha = 0
                        view.isHidden = true
                    }
                } else if toolsViewHeightConstraint.constant == 255 {
                    //only show 6,7 { h=107 }
                    toolsViewHeightConstraint.constant = 107
                    for n in 0...5 {
                        let view = htmlKeyboard.arrangedSubviews[n]
                        view.alpha = 0
                        view.isHidden = true
                    }
                } else if toolsViewHeightConstraint.constant == 329 {
                    //show all but not 3,4 { h=255 }
                    webViewWidthConstraint.constant = 160
                    toolsViewHeightConstraint.constant = 255
                    for n in 3...4 {
                        let view = htmlKeyboard.arrangedSubviews[n]
                        view.alpha = 0
                        view.isHidden = true
                    }
                }
            default:
                break
            }
            UIView.animate(withDuration: 0.15) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @IBAction func didPressCloseButton(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func didPressArrow(_ sender: UIButton) {
        mindMap.updateSelectedNode(Direction(rawValue: sender.tag))
    }
    
    @IBAction func didPressAddElement(_ sender: UIButton) {
        print("\(#function)ing...")
        let htmlTags = [
            "span","canvas","div",
            "button","a","input",
            "textArea","form","label",
            "option","legend","select",
            "fieldSet","optGroup","output",
            "video","img","audio",
            "li","h1","p",
            "ul","br","hr",
        ]
        if sender.tag > 0 && sender.tag < htmlTags.count {
            mindMap.add(tag: htmlTags[sender.tag])
        }
    }
    
    @IBAction func didPressUndo(_ sender: UIButton) {
        print("\(#function)ing...")
        ReduxStore.dispatch(UndoAction())
    }
    
    @IBAction func didPressRedo(_ sender: UIButton) {
        print("\(#function)ing...")
        ReduxStore.dispatch(RedoAction())
    }
    
    @IBAction func didChangeAttributesViewSegmentedControl(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            attributesStackView.arrangedSubviews[1].isHidden = false
            attributesStackView.arrangedSubviews[2].isHidden = true
            attributesStackView.arrangedSubviews[3].isHidden = true
        case 1:
            attributesStackView.arrangedSubviews[1].isHidden = true
            attributesStackView.arrangedSubviews[2].isHidden = false
            attributesStackView.arrangedSubviews[3].isHidden = true
        default:
            attributesStackView.arrangedSubviews[1].isHidden = true
            attributesStackView.arrangedSubviews[2].isHidden = true
            attributesStackView.arrangedSubviews[3].isHidden = false
        }
    }
    
    func toggleTextDecoration(button: UIButton, turnOn: Bool) {
        button.tintColor = turnOn ? .systemBlue : .label
    }
    
    @IBAction func didPressTextDecoration(_ sender: UIButton) {
        print("\(#function)ing...")
        guard let project = project else { return }
        let textDecorations = TextDecoration.allCases
        
        ReduxStore.dispatch(UpdateAction(handler: {
            project.toggleSelectedElementText(decoration: textDecorations[sender.tag])
        }))
        
    }
    
    @IBAction func didChangeTextAlignmentSegmentedControl(_ sender: UISegmentedControl) {
        guard let project = project else { return }
        let selectedAlignment = TailwindCSS.textAlign[sender.selectedSegmentIndex]
        ReduxStore.dispatch(UpdateAction(handler: {
            project.setSelectedElementText(alignment: selectedAlignment)
        }))
    }
    
    var selectedColorWell: UIColorWell?
    @IBAction func didPressSelectColorButton(_ sender: UIButton) {
        selectedColorWell = sender.tag == 0 ? textColorWell : backgroundColorWell
        let colorPickerVC = UIColorPickerViewController()
        colorPickerVC.delegate = self
        present(colorPickerVC, animated: true)
    }
    
    @IBAction func didChangeHiddenSwitch(_ sender: UISwitch) {
        guard let project = project else { return }
        ReduxStore.dispatch(UpdateAction(handler: {
            project.setSelectedElementHidden(sender.isOn)
        }))
    }
    
    
}

extension MindMapVC: UIColorPickerViewControllerDelegate {
    func colorPickerViewController(_ viewController: UIColorPickerViewController, didSelect color: UIColor, continuously: Bool) {
        guard !continuously else { return }
        guard let project = project else { return }
        switch selectedColorWell {
        case textColorWell:
            textColorWell.selectedColor = color
            ReduxStore.dispatch(UpdateAction(handler: {
                project.setSelectedElementText(color: color)
            }))
        case backgroundColorWell:
            backgroundColorWell.selectedColor = color
            ReduxStore.dispatch(UpdateAction(handler: {
                project.setSelectedElementBackground(color: color)
            }))
        default:
            break
        }
        
    }
}

extension MindMapVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return tailwindClassNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tailwindClassNames[section].array.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tailwindCell", for: indexPath) as? TailwindCollectionViewCell else { return UICollectionViewCell() }
        cell.configure(title: tailwindClassNames[indexPath.section].array[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width/2) - 20, height: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let project = project else { return }
        ReduxStore.dispatch(UpdateAction(handler: {
            project.toggleSelectedElement(className: self.tailwindClassNames[indexPath.section].array[indexPath.row])
        }))
    }
    
}


extension MindMapVC: UIMindMapDelegate {
    func didRemoveNode() {
        loadWebView()
    }
}

extension MindMapVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
    }
    
    @IBAction func didEndEditingTextContent(_ sender: UITextField) {
        guard let project = project, let text = sender.text else { return }
        ReduxStore.dispatch(UpdateAction(handler: {
            project.setSelectedElementText(content: text)
        }))
    }
    
    @IBAction func didEndEditingElementSource(_ sender: UITextField) {
        guard let project = project, let text = sender.text else { return }
        ReduxStore.dispatch(UpdateAction(handler: {
            project.setSelectedElement(source: text)
        }))
    }
    
    @IBAction func editingTailwindSearch(_ sender: UITextField) {
        guard let searchQuery = sender.text else { return }
        tailwindClassNames = TailwindCSS.all // TODO: refactor this ugly code 🫣
        if !searchQuery.isEmpty {
            var filteredClassNames = [String]()
            for classNameSet in tailwindClassNames {
                filteredClassNames += classNameSet.array.filter { $0.contains(searchQuery)}
            }
            tailwindClassNames = [(name: .none, array: filteredClassNames)]
        }
        
        tailwindCollectionView.reloadData()
    }
    
    
}

extension MindMapVC: StoreSubscriber {
    override func viewWillAppear(_ animated: Bool) {
        ReduxStore.subscribe(self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        ReduxStore.unsubscribe(self)
    }
    
    func newState(state: ReduxState) {
        if project == nil {
            project = state.openedProject
            mindMap.project = project
        }
        
        
        
//        if let dailyChallenges = state.dailyChallenges {
        for challenge in state.dailyChallenges {
                if challenge.isComplete { continue }
                if let docString = state.openedProject?.getOuterHtml() {
                    if docString.contains(challenge.regex) {
                        view.presentConfettiAnimation()
                        challenge.isComplete = true
                    }
                }
            }
//        }
        
        loadWebView()/*🤔*/
        mindMap.loadBody()
        
        projectTitle.text = project?.getDocumentTitle()
        
        if let selectedElementText = project?.getSelectedElement()?.ownText() {
            contentTextField.text = selectedElementText
        }
        
        if let selectedElementTextDecorations = project?.getSelectedElementTextDecorations() {
            textDecorationButtons.enumerated().forEach { (index, button) in
                let decoration = TextDecoration.allCases[index]
                toggleTextDecoration(button: button, turnOn: selectedElementTextDecorations.contains(decoration))
            }
        }
        
        if let selectedElementTextAlignment = project?.getSelectedElementTextAlignment() {
            if let index = TailwindCSS.textAlign.firstIndex(of: selectedElementTextAlignment) {
                textAlignmentSegmentedControl.selectedSegmentIndex = index
            }
        } else {
            textAlignmentSegmentedControl.selectedSegmentIndex = 0
        }
        
        if let selectedElementType = project?.getSelectedElementType() {
            typeButton.setTitle(selectedElementType, for: .normal)
        }
        
        if let selectedElementListStyle = project?.getSelectedElementListStyle() {
            listStyleButton.setTitle(selectedElementListStyle, for: .normal)
        }
        
        if let selectedElementSemantic = project?.getSelectedElementSemantic() {
            semanticButton.setTitle(selectedElementSemantic, for: .normal)
        }
        
        if let selectedElementSource = project?.getSelectedElementSource() {
            sourceTextField.text = selectedElementSource
        }
        
        idTextField.placeholder = project?.selectedElementID
        
        // TODO: update the backgroundColorWell & textColorWell selected color
        if let backgroundColor = project?.getSelectedElementBackgroundColor() {
            //            backgroundColorWell.selectedColor = backgroundColor
        }
        
        if let textColor = project?.getSelectedElementTextColor() {
            //            textColorWell.selectedColor = textColor
        }
        
        if let isHidden = project?.isSelectedElementHidden() {
            hiddenSwitch.isOn = isHidden
        }
        
    }
}
