//
//  RealmProjectModels.swift
//  CAOCAP
//
//  Created by Azzam AL-Rashed on 19/07/2023.
//

import Foundation
import RealmSwift

final class RProjects: Object {
    @Persisted(primaryKey: true) var _id = "Projects"
    @Persisted var values = List<RProject>()
    
    convenience init(values: List<RProject>) {
        self.init()
        self.values = values
    }
    
}


final class RProject: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    
    @Persisted var document = ""
    @Persisted var history = List<String>()
    @Persisted var selectedElementID = ""
    
    convenience init(document: String, history: List<String>, selectedElementID: String) {
        self.init()
        self.document = document
        self.history = history
        self.selectedElementID = selectedElementID
    }
}
