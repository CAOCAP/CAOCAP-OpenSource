//
//  AttributesToolKit.swift
//  CAOCAP
//
//  Created by الشيخ عزام on 11/08/2024.
//

import UIKit

class AttributesToolKit: ToolKitVC {
    
    //MARK: Outlets
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMenuButtons()
    }
    
    
    override func newState(state: ReduxState) {
        super.newState(state: state)
        updateContentTextField()
        updateTextDecorationButtons()
        updateTextAlignmentSegmentedControl()
        updateTypeButton()
        updateListStyleButton()
        updateSemanticButton()
        updateSourceTextField()
        updateIDTextField()
        updateColorWells()
        updateHiddenSwitch()
    }

    /// Updates the content text field with the selected element's text.
    private func updateContentTextField() {
        if let selectedElementText = project?.getSelectedElement()?.ownText() {
            contentTextField.text = selectedElementText
        }
    }
    
    /// Updates the text decoration buttons based on the selected element's decorations.
    private func updateTextDecorationButtons() {
        if let selectedElementTextDecorations = project?.getSelectedElementTextDecorations() {
            textDecorationButtons.enumerated().forEach { (index, button) in
                let decoration = TextDecoration.allCases[index]
                toggleTextDecoration(button: button, turnOn: selectedElementTextDecorations.contains(decoration))
            }
        }
    }

    /// Updates the segmented control for text alignment based on the selected element's alignment.
    private func updateTextAlignmentSegmentedControl() {
        if let selectedElementTextAlignment = project?.getSelectedElementTextAlignment(),
           let index = TailwindCSS.textAlign.firstIndex(of: selectedElementTextAlignment) {
            textAlignmentSegmentedControl.selectedSegmentIndex = index
        } else {
            textAlignmentSegmentedControl.selectedSegmentIndex = 0
        }
    }

    /// Updates the type button with the selected element's type.
    private func updateTypeButton() {
        if let selectedElementType = project?.getSelectedElementType() {
            typeButton.setTitle(selectedElementType, for: .normal)
        }
    }

    /// Updates the list style button with the selected element's list style.
    private func updateListStyleButton() {
        if let selectedElementListStyle = project?.getSelectedElementListStyle() {
            listStyleButton.setTitle(selectedElementListStyle, for: .normal)
        }
    }

    /// Updates the semantic button with the selected element's semantic type.
    private func updateSemanticButton() {
        if let selectedElementSemantic = project?.getSelectedElementSemantic() {
            semanticButton.setTitle(selectedElementSemantic, for: .normal)
        }
    }

    /// Updates the source text field with the selected element's source.
    private func updateSourceTextField() {
        if let selectedElementSource = project?.getSelectedElementSource() {
            sourceTextField.text = selectedElementSource
        }
    }

    /// Updates the ID text field's placeholder with the selected element's ID.
    private func updateIDTextField() {
        idTextField.placeholder = project?.selectedElementID
    }

    /// Updates the color wells based on the selected element's background and text colors.
    ///
    /// - Note: The color wells are currently commented out for future implementation.
    private func updateColorWells() {
        // TODO: update the backgroundColorWell & textColorWell selected color
        if let backgroundColor = project?.getSelectedElementBackgroundColor() {
            // backgroundColorWell.selectedColor = backgroundColor
        }
        
        if let textColor = project?.getSelectedElementTextColor() {
            // textColorWell.selectedColor = textColor
        }
    }

    /// Updates the state of the hidden switch based on the selected element's hidden property.
    private func updateHiddenSwitch() {
        if let isHidden = project?.isSelectedElementHidden() {
            hiddenSwitch.isOn = isHidden
        }
    }
    
    
    
    // MARK: - Menu Buttons
    /// Set up the menu buttons for type, semantic, and list style options.
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
    
    
    
    /// Toggles the text decoration on or off for a given button.
    ///
    /// - Parameters:
    ///   - button: The button representing the text decoration.
    ///   - turnOn: A boolean value indicating whether to turn the decoration on or off.
    func toggleTextDecoration(button: UIButton, turnOn: Bool) {
        button.tintColor = turnOn ? .systemBlue : .label
    }
    
    /// Toggles the text decoration for the selected element based on the button pressed.
    ///
    /// - Parameter sender: The button that triggered this action.
    @IBAction func didPressTextDecoration(_ sender: UIButton) {
        print("\(#function)ing...")
        guard let project = project else { return }
        let textDecorations = TextDecoration.allCases
        
        ReduxStore.dispatch(UpdateAction(handler: {
            project.toggleSelectedElementText(decoration: textDecorations[sender.tag])
        }))
        
    }
    
    /// Changes the text alignment of the selected element based on the selected segment in the segmented control.
    ///
    /// - Parameter sender: The segmented control that triggered this action.
    @IBAction func didChangeTextAlignmentSegmentedControl(_ sender: UISegmentedControl) {
        guard let project = project else { return }
        let selectedAlignment = TailwindCSS.textAlign[sender.selectedSegmentIndex]
        ReduxStore.dispatch(UpdateAction(handler: {
            project.setSelectedElementText(alignment: selectedAlignment)
        }))
    }
    
    
    var selectedColorWell: UIColorWell?
    /// Presents the color picker for selecting text or background color.
    ///
    /// - Parameter sender: The button that triggered this action.
    @IBAction func didPressSelectColorButton(_ sender: UIButton) {
        selectedColorWell = sender.tag == 0 ? textColorWell : backgroundColorWell
        let colorPickerVC = UIColorPickerViewController()
        colorPickerVC.delegate = self
        present(colorPickerVC, animated: true)
    }
    
    /// Toggles the visibility of the selected element.
    @IBAction func didChangeHiddenSwitch(_ sender: UISwitch) {
        guard let project = project else { return }
        ReduxStore.dispatch(UpdateAction(handler: {
            project.setSelectedElementHidden(sender.isOn)
        }))
    }
}

// MARK: - UIColorPickerViewControllerDelegate
extension AttributesToolKit: UIColorPickerViewControllerDelegate {
    
    /// Handles the color selection in the color picker view controller.
    ///
    /// - Parameters:
    ///   - viewController: The color picker view controller.
    ///   - color: The selected color.
    ///   - continuously: A boolean value indicating whether the color selection is continuous.
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



// MARK: - UITextFieldDelegate
extension AttributesToolKit: UITextFieldDelegate {
    
    /// Handles the return key press event on the text field.
    ///
    /// - Parameter textField: The text field whose return button was pressed.
    /// - Returns: A boolean value indicating whether the text field should process the return button press.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
    }
    
    /// Handles the event when a HTML element text content editing ends.
    ///
    /// - Parameter sender: The text field that triggered the event.
    @IBAction func didEndEditingTextContent(_ sender: UITextField) {
        guard let project = project, let text = sender.text else { return }
        ReduxStore.dispatch(UpdateAction(handler: {
            project.setSelectedElementText(content: text)
        }))
    }
    
    /// Handles the event when a HTML element source editing ends.
    ///
    /// - Parameter sender: The text field that triggered the event.
    @IBAction func didEndEditingElementSource(_ sender: UITextField) {
        guard let project = project, let text = sender.text else { return }
        ReduxStore.dispatch(UpdateAction(handler: {
            project.setSelectedElement(source: text)
        }))
    }
    
}

