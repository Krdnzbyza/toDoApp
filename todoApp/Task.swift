
import Foundation

struct Task : Identifiable {
    let id =  UUID()
    let name : String
    var isCompleted : Bool
    var lastCompleted : Date?
}

