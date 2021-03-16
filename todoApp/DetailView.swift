
import SwiftUI

struct DetailsView: View {
    @Binding var task : Task // bağlayıcı,sarmalar
    var body: some View {
        VStack {
            Text(task.name)
            Text (" Are you ready day ?")
            Button("Mark Completed") {
                    task.isCompleted = true
                
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView(task: Binding<Task>.constant( Task (name: " Test task", isCompleted: false , lastCompleted: nil))
        )
    }
}
