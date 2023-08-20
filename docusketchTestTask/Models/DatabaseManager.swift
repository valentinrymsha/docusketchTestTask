import Foundation
import RealmSwift

final class DatabaseManager {
    
    static var realm: Realm {
        get {
            do {
                let realm = try Realm()
                return realm
            }
            catch {
                print(DBErrors.notExistDBError.localDescription)
            }
            return self.realm
        }
    }
    
    public static func write(realm: Realm, writeClosure: () -> ()) {
        do {
            try realm.write {
                writeClosure()
            }
        } catch {
            print(DBErrors.accessDBError.localDescription)
        }
    }
}


