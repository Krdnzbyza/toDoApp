

import Foundation

class TodoTask: ObservableObject{
    @Published var dailyTasks = [
        
        Task(name: "Check All Task", isCompleted: false, lastCompleted: nil),
        Task(name: "Read a Book", isCompleted: false, lastCompleted: nil),
        Task(name: "Gym and walking", isCompleted: false, lastCompleted: nil),
        
    ]
    @Published var weeklyTasks = [
        Task(name: "-Write an article", isCompleted: false, lastCompleted: nil),
        Task(name: " Fınısh a movie", isCompleted: false, lastCompleted: nil),
        Task(name: " Planing weekly plan", isCompleted: false, lastCompleted: nil),
        Task(name: " Clean the room", isCompleted: false, lastCompleted: nil),
        
    ]
    @Published var monhtlyTasks = [
        Task(name: "Check mission", isCompleted: false, lastCompleted: nil),
        Task(name: "Control monthly task", isCompleted: false, lastCompleted: nil),
        
    ]
    
}
