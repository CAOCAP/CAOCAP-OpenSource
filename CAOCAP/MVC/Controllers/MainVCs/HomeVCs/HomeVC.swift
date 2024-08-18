//
//  HomeVC.swift
//  CAOCAP
//
//  Created by Azzam AL-Rashed on 13/06/2023.
//

import UIKit
import ReSwift
import SwiftUI
import StoreKit
import Popovers

class HomeVC: UIViewController, Storyboarded {
    
    var user: User?
    
    @IBOutlet weak var welcomingLabel: UILabel!
    @IBOutlet weak var uidLabel: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var appVersion: UILabel!
    @IBOutlet weak var purchaseButton: UIButton!
    @IBOutlet weak var proStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appVersion.text = getVersion()
        setupStackView()
        fetchProSubscriptionStatus()
    }
    
    func setupProSubscriptionStatus() {
        if UserDefaults.standard.isSubscribed {
            welcomingLabel.text = "Welcome, back pro user 👑👋🏼"
            purchaseButton.isHidden = true
            proStackView.isHidden = false
        } else {
            welcomingLabel.text = "Welcome, back user 👋🏼"
            purchaseButton.isHidden = false
            proStackView.isHidden = true
        }
    }
    
    func fetchProSubscriptionStatus() {
        setupProSubscriptionStatus()
        Task {
            // Start with the assumption that the user has no subscription
            var hasNoSubscription = true
            
            for await result in StoreKit.Transaction.currentEntitlements {
                if case .verified(let transaction) = result {
                    // Check if the current transaction is still valid
                    if isTransactionValid(transaction) {
                        // If valid, mark as subscribed
                        hasNoSubscription = false
                        
                    } else {
                        // If not valid, mark as not subscribed
                        
                    }
                }
            }
            
            UserDefaults.standard.isSubscribed = !hasNoSubscription
            setupProSubscriptionStatus()
        }
    }

    private func isTransactionValid(_ transaction: StoreKit.Transaction) -> Bool {
        // Implement your logic to determine if the transaction is still valid
        // For example, check the expiration date for subscriptions
        guard let expirationDate = transaction.expirationDate else {
            return false
        }
        return expirationDate > Date()
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
        coordinator.viewPurchase()
    }
    
    @IBAction func didPressExploreButton(_ sender: Any) {
        coordinator.viewWorld()
    }
    
    @IBAction func didPressStoreButton(_ sender: Any) {
        coordinator.viewStore()
    }
    
    @IBAction func didPressPaletteButton(_ sender: Any) {
        coordinator.viewPalette()
    }
    
    @IBAction func didPressJoinCommunity(_ sender: Any) {
        openURLInSafari(urlString: "https://chat.whatsapp.com/HGjW7xsdQY9EsKsF8ncZw6")
    }
    
    @IBAction func didPressTestFlight(_ sender: Any) {
        openURLInSafari(urlString: "https://testflight.apple.com/join/7QU881hQ")
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
        if user != state.user {
            user = state.user
            guard let uid = user?.uid else { return }
            uidLabel.text = uid
            FirebaseRepository.shared.getCommits(uid: uid)
        }

        if let commits = state.commitHistory {
            print(commits)
        }
        
        if state.isSubscribed {
            setupProSubscriptionStatus()
        }
    }
}
