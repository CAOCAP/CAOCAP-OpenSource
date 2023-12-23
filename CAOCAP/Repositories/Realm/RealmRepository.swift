//
//  RealmRepository.swift
//  CAOCAP
//
//  Created by Azzam AL-Rashed on 19/07/2023.
//

import Foundation
import RealmSwift

// MARK: - Realm Repository

final class RealmRepository {
    static let shared = RealmRepository()
    
    private lazy var localRealm:Realm = {
        return try! Realm()
    }()
    
    func configuration() {
        let config = Realm.Configuration(
            // Set the new schema version. This must be greater than the previously used
            schemaVersion: 1,
         
            // Set the block which will be called automatically when opening a Realm with
            // a schema version lower than the one set above
            migrationBlock: { migration, oldSchemaVersion in
                // We haven’t migrated anything yet, so oldSchemaVersion == 0
                if (oldSchemaVersion < 1) {
                    // Nothing to do!
                    // Realm will automatically detect new properties and removed properties
                    // And will update the schema on disk automatically
                }
            })
         
        // Tell Realm to use this new configuration object for the default Realm
        Realm.Configuration.defaultConfiguration = config
         
        // Now that we've told Realm how to handle the schema change, opening the file
        // will automatically perform the migration
    }
    
    
    // MARK: - RProjects
    
    // MARK: Create
    private func createNewProject() -> RProjects {
        let projects = RProjects()
        do {
            try localRealm.write { localRealm.add(projects) }
        } catch {
            print("Error: \(#function), with error message: \(error)")
        }
        return projects
    }
    
    
    // MARK: Read
    func getProjects() -> RProjects {
        if let projects = localRealm.object(ofType: RProjects.self, forPrimaryKey: "Projects") {
            return projects
        } else {
            return createNewProject()
        }
    }
    
    // MARK: Update
    func add(project: RProject) {
        let projects = getProjects()
        do {
            try localRealm.write { projects.values.append(project) }
        } catch {
            print("Error: \(#function), with error message: \(error)")
        }
    }
    
    func edit(project: RProject, newTitle: String) {
        do {
//            try localRealm.write { project.title = newTitle}
        } catch {
            print("Error: \(#function), with error message: \(error)")
        }
    }
    
    
    // MARK: Delete
    func deleteAllProjects() -> RProjects? {
        if let projects = localRealm.object(ofType: RProjects.self, forPrimaryKey: "Projects") {
            do {
                try localRealm.write { localRealm.delete(projects) }
                return projects
            } catch {
                print("Error: \(#function), with error message: \(error)")
                return nil
            }
        }
        return nil
    }
    
    
}

