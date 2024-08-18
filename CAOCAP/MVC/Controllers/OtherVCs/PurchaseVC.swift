//
//  PurchaseVC.swift
//  CAOCAP
//
//  Created by Azzam AL-Rashed on 10/06/2023.
//

import UIKit
import StoreKit

class PurchaseVC: UIViewController, Storyboarded {
    private var monthlySubscription: Product?
    private var yearlySubscription: Product?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchProducts()
        listenForTransactionUpdates()
    }
    
    private func fetchProducts() {
        Task {
            do {
                self.monthlySubscription = try await Product.products(for:  ["CAOCAP_Pro_Monthly"]).first
                self.yearlySubscription = try await Product.products(for:  ["CAOCAP_Pro_Yearly"]).first
            } catch {
                print("Failed to fetch products: \(error)")
            }
        }
    }
    
    private func listenForTransactionUpdates() {
        Task {
            for await result in Transaction.updates {
                if case .verified(let transaction) = result {
                    unlockSubscription()
                    await transaction.finish()
                }
            }
        }
    }
    
    private func purchase(product: Product) {
        Task {
            do {
                let result = try await product.purchase()
                switch result {
                case .success(let verification):
                    if case .verified(let transaction) = verification {
                        await transaction.finish()
                        unlockSubscription()
                    }
                case .userCancelled, .pending:
                    break
                default:
                    break
                }
            } catch {
                print("Purchase failed: \(error)")
            }
        }
    }
    
    private func unlockSubscription() {
        // Set the subscription state to true
        UserDefaults.standard.isSubscribed = true
        ReduxStore.dispatch(SubscribeAction(subscriptionStatus: true))
        dismiss(animated: true)
    }
    
    @IBAction func didPressMonthly(_ sender: UIButton) {
        guard let subscription = monthlySubscription else { return }
        purchase(product: subscription)
    }
    
    @IBAction func didPressYearly(_ sender: UIButton) {
        guard let subscription = yearlySubscription else { return }
        purchase(product: subscription)
    }
    
    
    @IBAction func didPressRestoreButton(_ sender: Any) {
        Task {
            for await result in Transaction.currentEntitlements {
                if case .verified(let transaction) = result {
                    unlockSubscription()
                }
            }
        }
    }
    
    @IBAction func didPressContactButton(_ sender: Any) {
        //TODO: add a way to contact the subscription support team
    }
}

