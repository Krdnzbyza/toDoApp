
import SwiftUI

@main
struct todoAppApp: App {
    @StateObject private var todoTask =
        TodoTask()
    var body: some Scene {
        WindowGroup {
            ContentView(todoTask: todoTask )
        }
    }
}
