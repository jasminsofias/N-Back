

import SwiftUI

struct BackroundView: View {
    let width : CGFloat
    let height : CGFloat
    
    var body: some View {
        ZStack{
            Rectangle()
                .fill(Color(.black))
                .cornerRadius(20)
                .frame(width: 10, height: height, alignment: .center)
                .position(x: width/3, y: height/2 )
            
            Rectangle()
                .fill(Color(.black))
                .cornerRadius(20)
                .frame(width: 10, height: height, alignment: .center)
                .position(x: width*2/3, y: height/2 )
            
            Rectangle()
                .fill(Color(.black))
                .cornerRadius(20)
                .frame(width: width, height: 10, alignment: .center)
                .position(x: width/2, y: height/3 )
            
            Rectangle()
                .fill(Color(.black))
                .cornerRadius(20)
                .frame(width: width, height: 10, alignment: .center)
                .position(x: width/2, y: height*2/3)
        }
            
    }
}

struct BackroundView_Previews: PreviewProvider {
    static var previews: some View {
        BackroundView(width: 300, height: 300)
    }
}
