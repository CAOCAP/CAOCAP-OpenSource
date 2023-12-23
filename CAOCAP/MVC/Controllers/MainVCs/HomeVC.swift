//
//  HomeVC.swift
//  CAOCAP
//
//  Created by Azzam AL-Rashed on 13/06/2023.
//

import UIKit
import ReSwift
import SwiftUI
import Popovers

class HomeVC: UIViewController, Storyboarded {
    var coordinator: MainCoordinator?
    
//    var user: User?
    
    @IBOutlet weak var uidLabel: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var appVersion: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appVersion.text = getVersion()
        setupStackView()
    }
    
    func setupStackView() {
        var squares = [UIView]()
        let commitHistory = UserDefaults.standard.getCommitHistory()
        
        for _ in 0...16 {
            let stack = UIStackView()
            for _ in 0...6 {
                let square = UIView()
                square.alpha = 0.4
                square.backgroundColor = .systemGray5
                square.cornerRadius = 2
                squares.append(square)
                stack.addArrangedSubview(square)
            }
            stack.spacing = 3
            stack.axis = .vertical
            stack.distribution = .fillEqually
            stackView.addArrangedSubview(stack)
        }
        squares.reverse()
        for commit in commitHistory {
            if let numberOfDays = Calendar.current.dateComponents([.day], from: commit, to: .now).day {
                if numberOfDays >= 0 && numberOfDays < squares.count {
                    let square = squares[numberOfDays]
                    square.backgroundColor = .label
                    if square.alpha < 1.0 {
                        square.alpha += 0.1
                    }
                }
            }
        }
    }
    
    @IBAction func didPressCommitHistory(_ sender: UIButton) {
        var popover = Popover { Templates.Container { Text("this is your commit history") } }
        popover.attributes.sourceFrame = { [weak sender] in sender.windowFrame() }
        popover.attributes.position = .absolute(originAnchor: .top, popoverAnchor: .bottom)
        popover.attributes.presentation.animation = .spring(response: 0.6, dampingFraction: 0.4, blendDuration: 1)
        popover.attributes.presentation.transition = .offset(x: 0, y: 30).combined(with: .opacity)
        popover.attributes.dismissal.transition = .offset(x: 0, y: 30).combined(with: .opacity)
        
        
        present(popover)
    }
    
    
    
    @IBAction func didPressChallenge(_ sender: UIButton) {
        let challenges = ["set a new web page title", "change <body> background color", "add an image with a source URL"]
        var popover = Popover {
            Templates.Container {
                Text(challenges[sender.tag])
                    .frame(maxWidth: 150)
                    .lineLimit(5)
                    .scaledToFill()
                    .minimumScaleFactor(0.5)
                    .multilineTextAlignment(.center)
            }
        }
        popover.attributes.sourceFrame = { [weak sender] in sender.windowFrame() }
        popover.attributes.screenEdgePadding.horizontal = 5
        popover.attributes.position = .absolute(originAnchor: .bottom, popoverAnchor: .top)
        popover.attributes.presentation.animation = .spring(response: 0.6, dampingFraction: 0.4, blendDuration: 1)
        popover.attributes.presentation.transition = .offset(x: 0, y: 30).combined(with: .opacity)
        popover.attributes.dismissal.transition = .offset(x: 0, y: 30).combined(with: .opacity)
        present(popover)
    }
    
    func getVersion() -> String {
        guard let dictionary = Bundle.main.infoDictionary,
              let version = dictionary["CFBundleShortVersionString"] as? String,
              let build = dictionary["CFBundleVersion"] as? String
        else { return "0.0.0 (0)" }
        return "\(version) (\(build))"
    }
    
    
    @IBAction func didPressPurchaseButton(_ sender: Any) {
        coordinator?.viewPurchase()
    }
    
    @IBAction func didPressPaletteButton(_ sender: Any) {
        coordinator?.viewPalette()
    }
    
    
    
}

extension HomeVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
    }
}


extension HomeVC: StoreSubscriber {
    override func viewWillAppear(_ animated: Bool) {
        ReduxStore.subscribe(self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        ReduxStore.unsubscribe(self)
    }
    
    func newState(state: ReduxState) {
        /*
        if user != state.user {
            user = state.user
            guard let uid = user?.uid else { return }
            uidLabel.text = uid
            FirebaseRepository.shared.getCommits(uid: uid)
        }
         */

        if let commits = state.commitHistory {
            print(commits)
        }
    }
}
