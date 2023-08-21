import Foundation
import RealmSwift

final class TaskModel: Object {
    
    @Persisted var task = String()
    @Persisted var done = Bool()
   
}
