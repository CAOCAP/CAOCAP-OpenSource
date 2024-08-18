//
//  ProjectLanguageVC.swift
//  CAOCAP
//
//  Created by Azzam AL-Rashed on 22/07/2023.
//

import UIKit
import ReSwift

class ProjectLanguageVC: UIViewController, Storyboarded {
    
    @IBOutlet weak var tableView: UITableView!
    var selectedCode: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(ISOLanguageCodeCell.self,forCellReuseIdentifier: ISOLanguageCodeCell.identifier)
    }
}


extension ProjectLanguageVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isoLanguageCodes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ISOLanguageCodeCell.identifier, for: indexPath) as? ISOLanguageCodeCell else { return UITableViewCell() }
        let iso = isoLanguageCodes[indexPath.row]
        cell.language = iso.lang
        cell.code = iso.code
        if iso.code == selectedCode {
            tableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        ReduxStore.dispatch(UpdateProjectLangAction(lang: isoLanguageCodes[indexPath.row].code))
    }
}


extension ProjectLanguageVC: StoreSubscriber {
    override func viewWillAppear(_ animated: Bool) {
        ReduxStore.subscribe(self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        ReduxStore.unsubscribe(self)
    }
    
    func newState(state: ReduxState) {
        selectedCode = state.openedProject?.getDocumentLang()
    }
}
