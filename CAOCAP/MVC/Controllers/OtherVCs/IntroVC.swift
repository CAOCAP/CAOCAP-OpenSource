//
//  IntroVC.swift
//  CAOCAP
//
//  Created by Azzam AL-Rashed on 03/07/2023.
//

import UIKit

class IntroVC: UIViewController {

    @IBOutlet weak var greetingsLabel: UILabel!
    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var subjectLabel: UILabel!
    @IBOutlet weak var pageControl: UIPageControl!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func didPressStart(_ sender: Any) {
        UserDefaults.standard.introCompleted()
        dismiss(animated: true)
    }
    
    @IBAction func didEndEditingUserName(_ sender: UITextField) {
        if sender.text == "" {
            sender.text = "Anonymous User"
        }
    }
    
    

}

extension IntroVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
    }
}
