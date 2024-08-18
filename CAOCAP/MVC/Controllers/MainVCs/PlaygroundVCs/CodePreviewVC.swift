//
//  CodePreviewVC.swift
//  CAOCAP
//
//  Created by الشيخ عزام on 19/01/1446 AH.
//

import UIKit
import ReSwift
import SwiftSoup

class CodePreviewVC: UIViewController, Storyboarded {

    var project: Project?
    @IBOutlet weak var projectTitle: UILabel!
    @IBOutlet weak var projectCode: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func loadProjectCode() {
        guard let project = project, let document = project.document else { return }
        do {
            projectTitle.text = project.getDocumentTitle()
            projectCode.text = try document.outerHtml()
        } catch Exception.Error(let type, let message) {
            print(type, message)
        } catch {
            print("error")
        }
    }

}

extension CodePreviewVC: StoreSubscriber {
    override func viewWillAppear(_ animated: Bool) {
        ReduxStore.subscribe(self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        ReduxStore.unsubscribe(self)
    }
    
    func newState(state: ReduxState) {
        if project == nil {
            project = state.openedProject
            loadProjectCode()
        }
    }
}
