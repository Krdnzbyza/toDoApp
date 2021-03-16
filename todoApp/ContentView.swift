
import SwiftUI

struct ContentView: View {
    @ObservedObject var todoTask :
        TodoTask // todoTask !!
    @State private var focusModeOn = false //when Focus mode is toggled,the uı update so use the state
    @State private var resetAlertShowing = true // initiial value to false and change it to
    //true when the user tap rthe reset button
    var body: some View {
        NavigationView {
            List  {
                Section(header :
                            TaskHeaderSection(
                                symbolSystemName: "moon.stars.fill",
                                headerText : " Daily Task") ) {
                    let taskIndices = todoTask.dailyTasks.indices
                    let tasks = todoTask.dailyTasks
                    let taskIndexPairs = Array(zip(tasks, taskIndices))
                    ForEach(
                        taskIndexPairs, id :\.0.id,  content : { // tuple and array
                            task, taskIndex in
                            let toDoTaskWrapper = $todoTask // for wrap to observable  object
                            let tasksBinding = toDoTaskWrapper.dailyTasks// dailytask '$' not use and go to daily rask selection because we dont use publısher
                            let theTaskBinding = tasksBinding[taskIndex] //task ındex decision and tick
//                            then after toggled bar
                            //always show with Focus mode is OFF
                            //when focus mode is ON and
                            // the task is INcompleted //tıklandığında -onoff geçişi
                            if focusModeOn  == false || (focusModeOn && task.isCompleted == false) {
                                NavigationLink(
                                    destination: DetailsView(task: theTaskBinding),
                                    label: {
                                        taskRow(task: task)
                                })
                            }
                        })
                        .onDelete(perform: { indexSet in // for remove the task
                            todoTask.dailyTasks.remove(atOffsets:  indexSet)
                        })
                        .onMove(perform: { indices, newOffset in
                            todoTask.dailyTasks.move(fromOffsets: indices, toOffset: newOffset)
                            
                        })
                }
                Section(header :
                            TaskHeaderSection(symbolSystemName: "highlighter", headerText: "Weekly Task") ){
                    let taskIndices = todoTask.weeklyTasks.indices
                    let tasks = todoTask.weeklyTasks
                    let taskIndexPairs = Array( zip(tasks, taskIndices) )
                    ForEach(
                        taskIndexPairs, id :\.0.id,  content : { // tuple and array
                            task, taskIndex in
                            let toDoTaskWrapper = $todoTask
                            let tasksBinding = toDoTaskWrapper.weeklyTasks
                            let theTaskBinding = tasksBinding[taskIndex]
                            
                            if focusModeOn == false || (focusModeOn &&
                                task.isCompleted == false) {
                                NavigationLink(
                                destination: DetailsView(
                                    task: theTaskBinding),
                                    label: {
                                        taskRow(task: task)
                                })
                            }
                            
                        })
                        .onDelete(perform: { indexSet in
                            todoTask.weeklyTasks.remove(atOffsets:  indexSet)
                        })
                        .onMove(perform: { indices, newOffset in
                            todoTask.weeklyTasks.move(fromOffsets: indices, toOffset: newOffset)
                            
                        })
                    
                    
                }
                Section(header :
                            TaskHeaderSection(symbolSystemName: "calendar", headerText: "Monthly Task"))  {
                    let taskIndices = todoTask.monhtlyTasks.indices
                    let tasks = todoTask.monhtlyTasks
                    let taskIndexPairs = Array( zip(tasks, taskIndices) )
                        ForEach(
                            taskIndexPairs, id :\.0.id,  content :{
                                task,taskIndex in
                            let toDoTaskWrapper = $todoTask
                            let tasksBinding = toDoTaskWrapper.monhtlyTasks
                            let theTasksBinding = tasksBinding[taskIndex]
                                if focusModeOn == false || (focusModeOn && task.isCompleted == false) {
                                    NavigationLink(
                                        destination: DetailsView(
                                        task: theTasksBinding),
                                        label: {
                                taskRow(task: task)
                                    })
                                }
                    })
                            .onDelete(perform: { indexSet in
                                todoTask.monhtlyTasks.remove(atOffsets:  indexSet)
                            })
                            .onMove(perform: { indices, newOffset in
                                todoTask.monhtlyTasks.move(fromOffsets: indices, toOffset: newOffset)
                                
                            })
                }
            }
            .listStyle(GroupedListStyle())
            .navigationTitle("Home")
            .toolbar {
                ToolbarItem(placement : .navigationBarLeading ){
                    EditButton( )
                }
                ToolbarItem(placement : .navigationBarTrailing ){
                    Button( "Reset"){ // update everything
                        resetAlertShowing = true
                    }
                }
                ToolbarItem(placement: .bottomBar){//toggle
                    Toggle(isOn:
                            $focusModeOn, label:
                                {
                        Text("Focus Mode")
                    })
                }
            }
            .navigationTitle("Home")
        }.alert(isPresented: $resetAlertShowing , content: { // if ı delete task ,tap the reset button
            Alert(title: Text("Reset List"),                 // the alert  pop up
                  message: Text("Are you sure ?"),
                  primaryButton: .cancel(), //exit alert
                  secondaryButton: .destructive(Text("Yes, reset it"),
                    action: {// reset the task
                       let refreshedToDoTask =
                            TodoTask()
                        self.todoTask.dailyTasks =
                            refreshedToDoTask.dailyTasks
                        self.todoTask.weeklyTasks =
                            refreshedToDoTask.weeklyTasks
                        self.todoTask.monhtlyTasks =
                            refreshedToDoTask.monhtlyTasks
                  }))
        })    }
}
struct TaskHeaderSection: View {
    let symbolSystemName : String
    let headerText : String
    var body: some View {
        HStack {
            Text(Image(systemName: symbolSystemName))
                .fontWeight(.heavy)
                .foregroundColor(.purple)
            Text (headerText)
                .font(.title3)
                .fontWeight(.heavy)
                .foregroundColor(Color.purple)
        }
    }
}
struct taskRow: View {
    let task : Task
    var body: some View {
        VStack {
            if task.isCompleted {
                HStack {
                    Image(systemName: "checkmark.square")
                    Text(task.name)
                        .foregroundColor(.gray)
                        .strikethrough()
                }
            } else {
                HStack {
                    Image(systemName: "square")
                    Text(task.name)}
            }
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let todoTask = TodoTask()
        Group {
            ContentView(todoTask: todoTask)
            taskRow(task: Task(name: "Test task", isCompleted: false, lastCompleted: nil))
                .previewLayout(.fixed(width: 200, height: 80))
        }
    }
}



