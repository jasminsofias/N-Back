
import SwiftUI

struct BoardView: View {
    @EnvironmentObject var theViewModel : NbackVM
    @EnvironmentObject var theNB : NB
    @State var count = 20
    @State var setCount = 0
    @State var isRunning = false
    @State var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var points = 0
    @State var visualColor = Color.blue
    @State var audioColor = Color.blue
    @State var enterSetting = true
    
    var body: some View {
        VStack{
            NavigationLink(destination: SettingView().environmentObject(theNB), isActive: $enterSetting){
                Text("Settings")
                    .font(.system(size: 40, weight: .semibold, design: .rounded))
            }
            HStack{
                Text("Round count: ")
                Text("\(theNB.count)").onReceive(timer){
                    _ in
                    if theNB.count > 0 && isRunning{
                        theNB.count -= 1
                        theViewModel.resetRound()
                        if theNB.visual{
                            theViewModel.aMove(position: 1)
                            audioColor = Color.gray
                            visualColor = Color.blue
                        }else if theNB.audio{
                            theViewModel.aSound(position: 1)
                            visualColor = Color.gray
                            audioColor = Color.blue
                        }
                        
                    }else{
                        isRunning = false
                        self.timer.upstream.connect().cancel()
                    }
                    
                }
                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                .font(.system(size: 30, weight: .semibold, design: .rounded))
                
            }
            HStack{
                Text("Points: ")
                Text("\(points)")
                    .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    .font(.system(size: 30, weight: .semibold, design: .rounded))
            }  
            ZStack{
                
                BackroundView(width: 300, height: 300)
                
                ForEach(theViewModel.markers) { aMarker in
                    Marker(marker: aMarker.state, id: aMarker.id )
                        .position(x: CGFloat(50+aMarker.x*100), y: CGFloat(50+aMarker.y*100))
                }
            }
            .frame(width: 300, height: 300, alignment: .center)
            HStack{
                Button("Play"){
                    isRunning = true
                    timer = Timer.publish(every: theNB.time, on: .main, in: .common).autoconnect()
                    setCount = theNB.count
                }.padding()
                    .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    .font(.system(size: 50, weight: .bold, design: .rounded))
                Spacer()
                Button("Reset"){
                    theNB.count = setCount
                    points = 0
                    theViewModel.resetGame()
                    setCount = theNB.count
                }.padding()
                    .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    .font(.system(size: 50, weight: .bold, design: .rounded))
            }
            HStack{
                Button("Audio"){
                    if(theViewModel.isRight()){
                        points += 1
                    }else{
                        audioColor = Color.red
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                        audioColor = Color.blue
                    }
                }
                .foregroundColor(audioColor)
                .disabled(theNB.visual && theNB.count == 0)
                .font(.system(size: 40, weight: .bold, design: .rounded))
                Spacer()
                Button("Visual"){
                    if(theViewModel.isRight()){
                        points += 1
                    }else{
                        visualColor = Color.red
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                        visualColor = Color.blue
                    }
                }
                .foregroundColor(visualColor)
                .disabled(theNB.audio && theNB.count == 0) 
                .font(.system(size: 40, weight: .bold, design: .rounded))
                
            } 
            
            
        }
    
    }
    
}


struct BoardView_Previews: PreviewProvider {
    static var previews: some View {
        BoardView()
            .environmentObject(NbackVM())
            .environmentObject(NB())
    }
}
