//
//  FullScreenWebViewVC.swift
//  CAOCAP
//
//  Created by Azzam AL-Rashed on 13/01/2024.
//

import UIKit
import WebKit
import ReSwift
import SwiftSoup

class FullScreenWebViewVC: UIViewController, Storyboarded {

    var project: Project?
    @IBOutlet weak var projectTitle: UILabel!
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func loadWebView() {
        guard let project = project, let document = project.document else { return }
        do {
            let htmlCode = try document.outerHtml()
            projectTitle.text = project.getDocumentTitle()
            webView.loadHTMLString( htmlCode, baseURL: nil)
        } catch Exception.Error(let type, let message) {
            print(type, message)
        } catch {
            print("error")
        }
    }

}

extension FullScreenWebViewVC: StoreSubscriber {
    override func viewWillAppear(_ animated: Bool) {
        ReduxStore.subscribe(self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        ReduxStore.unsubscribe(self)
    }
    
    func newState(state: ReduxState) {
        if project == nil {
            project = state.openedProject
            loadWebView()
        }
    }
}
