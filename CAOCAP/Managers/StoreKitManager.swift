//
//  StoreKitManager.swift
//  CAOCAP
//
//  Created by Azzam AL-Rashed on 14/06/2023.
//
//  Abstract:
//  The store class is responsible for requesting products from the App Store and starting purchases.
// https://developer.apple.com/documentation/storekit/in-app_purchase/implementing_a_store_in_your_app_using_the_storekit_api


import Foundation
import StoreKit

typealias Transaction = StoreKit.Transaction
typealias RenewalInfo = StoreKit.Product.SubscriptionInfo.RenewalInfo
typealias RenewalState = StoreKit.Product.SubscriptionInfo.RenewalState

public enum StoreKitError: Error {
    case failedVerification
}

//Define our app's subscription tiers by level of service, in ascending order.
public enum SubscriptionTier: Int, Comparable {
    case none = 0
    case pro = 1

    public static func < (lhs: Self, rhs: Self) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
}


class StoreKitManager: ObservableObject {
    
    
    
    //Get a subscription's level of service using the product ID.
    func tier(for productId: String) -> SubscriptionTier {
        switch productId {
        case "subscription.pro":
            return .pro
        default:
            return .none
        }
    }
}
