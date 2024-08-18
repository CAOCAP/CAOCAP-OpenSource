//
//  UserDefaults.swift
//  CAOCAP
//
//  Created by Azzam AL-Rashed on 03/07/2023.
//

import Foundation

extension UserDefaults {
    
    private enum Keys {
        static let isSubscribed = "isSubscribed"
        static let introCompleted = "introCompleted"
    }
    
    var isSubscribed: Bool {
        get {
            return bool(forKey: Keys.isSubscribed)
        }
        set {
            set(newValue, forKey: Keys.isSubscribed)
        }
    }
    
    var introCompleted: Bool {
        get {
            return bool(forKey: Keys.introCompleted)
        }
        set {
            set(newValue, forKey: Keys.introCompleted)
        }
    }
    
    
    func getCommitHistory() -> [Date] {
        return array(forKey: "CommitHistory") as? [Date] ?? []
    }
    
    func addCommit() {
        var newCommitHistory = getCommitHistory()
        newCommitHistory.append(.now)
        set(newCommitHistory, forKey: "CommitHistory")
    }
    
    func resetCommitHistory() {
        removeObject(forKey: "CommitHistory")
    }
}
