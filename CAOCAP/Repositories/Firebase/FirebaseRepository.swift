//
//  FirebaseRepository.swift
//  CAOCAP
//
//  Created by Azzam AL-Rashed on 06/08/2023.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseDatabase

// MARK: - Firebase References
fileprivate let database: DatabaseReference = Database.database().reference()
//fileprivate let cloudStorage: StorageReference = Storage.storage().reference()

// MARK: - Firebase Repository

final class FirebaseRepository {
    static let shared = FirebaseRepository()
    
    
    func configuration() {
        FirebaseApp.configure()
        anonymousAuth()
    }
    
    func anonymousAuth() {
        if let user = Auth.auth().currentUser {
            ReduxStore.dispatch(AuthUserAction(user: user))
        } else {
            Auth.auth().signInAnonymously { authResult, error in
                guard let user = authResult?.user else { return }
                ReduxStore.dispatch(AuthUserAction(user: user))
            }
        }
    }
    
    func commit(uid: String, value: String) {
        database.child("users").child(uid).setValue(["commit": value])
    }
    
    func getCommits(uid: String) {
        database.child("users").child(uid).observeSingleEvent(of: .value, with: { snapshot in
            // Get user value
            let value = snapshot.value as? NSDictionary
            let commit = value?["commit"] as? String ?? ""
            ReduxStore.dispatch(ReceivedCommitHistoryAction(commits: [commit]))
        }) { error in
          print(error.localizedDescription)
        }
    }
}
