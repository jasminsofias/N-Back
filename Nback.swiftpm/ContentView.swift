import SwiftUI

struct DeviceRotationViewModifier: ViewModifier {
    let action: (UIDeviceOrientation) -> Void
    
    func body(content: Content) -> some View {
        content
            .onAppear()
            .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
                action(UIDevice.current.orientation)
            }
    }
}

// A View wrapper
extension View {
    func onRotate(perform action: @escaping (UIDeviceOrientation) -> Void) -> some View {
        self.modifier(DeviceRotationViewModifier(action: action))
    }
}

struct ContentView: View {
    @EnvironmentObject var theViewModel : NbackVM
    @EnvironmentObject var nb : NB
    @State private var orientation = UIDeviceOrientation.portrait
    var body: some View {
        NavigationView{
            Group{
                if orientation.isPortrait{
                    VStack{
                        
                        BoardView()
                        
                    }
                    
                } else if orientation.isLandscape {
                    HStack{
                        VStack{
                            
                            BoardView()
                        }
                        .frame(width: 300, height: 300, alignment: .center)
                        
                                            }
                }
            }
            .onRotate { newOrientation in orientation = newOrientation}
        }
        .environmentObject(nb)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(NbackVM())
            .environmentObject(NB())
    }
}
