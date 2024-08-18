//
//  CoCaptainVC.swift
//  CAOCAP
//
//  Created by الشيخ عزام on 17/08/2024.
//

import UIKit

class CoCaptainVC: UIViewController, Storyboarded {
    
    @IBOutlet weak var promptTextField: UITextField!
    @IBOutlet weak var resultTextView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func generateButtonTapped(_ sender: UIButton) {
        guard let prompt = promptTextField.text, !prompt.isEmpty else {
            print("Prompt is empty.")
            return
        }

        // Use the OpenAIManager to generate a completion based on the prompt
        OpenAIManager.shared.generateCompletion(for: prompt) { [weak self] response in
            // Update the UI on the main thread
            DispatchQueue.main.async {
                if let completion = response {
                    self?.resultTextView.text = completion
                } else {
                    self?.resultTextView.text = "Failed to generate a response."
                }
            }
        }
    }
}
