//
//  DataManager.swift
//  docusketchTestTask
//
//  Created by Valentin on 18.08.23.
//

import Foundation
import RealmSwift

class Task: Object {
    @Persisted var task = String()
    @Persisted var done = Bool()
}
