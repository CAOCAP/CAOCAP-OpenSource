//
//  IntroVC.swift
//  CAOCAP
//
//  Created by Azzam AL-Rashed on 03/07/2023.
//

import UIKit
import SpriteKit

class IntroVC: UIViewController {

    @IBOutlet weak var greetingsLabel: UILabel!
    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var subjectLabel: UILabel!
    @IBOutlet weak var pageControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSpaceScene()
    }
    
    fileprivate func setupSpaceScene() {
        if let view = self.view as? SKView {
            let scene = SpaceScene(size: view.bounds.size)
            scene.scaleMode = .aspectFill
            view.presentScene(scene)
            view.ignoresSiblingOrder = true
        }
    }
    
    @IBAction func didPressStart(_ sender: Any) {
        UserDefaults.standard.introCompleted = true
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
