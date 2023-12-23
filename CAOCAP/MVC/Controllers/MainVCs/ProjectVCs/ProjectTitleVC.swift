//
//  ProjectTitleVC.swift
//  CAOCAP
//
//  Created by Azzam AL-Rashed on 22/07/2023.
//

import UIKit
import ReSwift

class ProjectTitleVC: UIViewController, Storyboarded {
    
    @IBOutlet weak var titleTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        titleTextField.becomeFirstResponder()
    }
    
}

extension ProjectTitleVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let title = titleTextField.text else { return false }
        ReduxStore.dispatch(UpdateProjectTitleAction(title: title))
        view.endEditing(true)
        dismiss(animated: true)
        return true
    }
}

extension ProjectTitleVC: StoreSubscriber {
    override func viewWillAppear(_ animated: Bool) {
        ReduxStore.subscribe(self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        ReduxStore.unsubscribe(self)
    }
    
    func newState(state: ReduxState) {
        titleTextField.text = state.openedProject?.getDocumentTitle()
    }
}
