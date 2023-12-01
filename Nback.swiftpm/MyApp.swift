import SwiftUI

@main
struct MyApp: App {
    @StateObject private var theViewModel = NbackVM()
    @StateObject private var theNB = NB()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(theViewModel)
                .environmentObject(theNB)
        }
    }
}
 
struct Previews_MyApp_Previews: PreviewProvider{
    static var previews: some View{
        Text("")
    }
}
