
import SwiftUI

struct DetailsView: View {
    let taskName : String
    var body: some View {
        VStack {
            Text(taskName)
            Text (" Are you ready day ?")
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView(taskName: "Plan")
    }
}
