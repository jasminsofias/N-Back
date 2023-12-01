

import Foundation
import AVFoundation

class NbackVM : ObservableObject  {
    let synthesizer = AVSpeechSynthesizer()
    var theModel = NbackModel()
    @Published var markers : [aMarker] = initMarkers()
    
    func resetGame(){
        markers = initMarkers()
        theModel.resetGame()
    }
    
    func resetRound(){
        markers = initMarkers()
        theModel.resetRound()
    }
    
    
    func aMove(position: Int){
        var position = position
        position = theModel.getRandomInt()
        print("aMove: \(position) ")
        let res = theModel.aMove(position: position)
        if res != 0 {
            markers[position].state = res
            
            let count = theModel.count
            DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
                self.hurryUP(moves: count)
            }
        }
        
    }
    
    func aSound(position: Int){
        var position = position
        position = theModel.getRandomInt()
        let res = theModel.aSound(position: position)
        let number = res.pos
        let letter = res.letter
        if number != 0{
            speech(letter: letter) 
            let count = theModel.count
            DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
                self.hurryUP(moves: count)
            }
        }
    }
    func hurryUP(moves: Int){
        print("moves: \(moves) ModelMoves: \(theModel.count)")
        if moves == theModel.count && moves < 10 {
            //  speech(tile: 3)
        }
    }
    
    func getTile(position: Int) -> Int{
        return theModel.gameState[position];
    }
    
    func checkWinner() -> Int{
        return theModel.checkWinner()
    }
    
    func isRight() -> Bool{
        return theModel.isRight()
    }
    
    func speech(letter:String){
        switch letter {
            
        case "Atta":
            let crossVoice = AVSpeechUtterance(string: "atta")
            synthesizer.stopSpeaking(at: AVSpeechBoundary.immediate )
            synthesizer.speak(crossVoice)
        case "Betta": 
            let br = AVSpeechUtterance(string: "betta")
            synthesizer.stopSpeaking(at: AVSpeechBoundary.immediate )
            synthesizer.speak(br)
        case "Cetta": let cr = AVSpeechUtterance(string: "cetta")
            synthesizer.stopSpeaking(at: AVSpeechBoundary.immediate )
            synthesizer.speak(cr)
        case "Detta": let dr = AVSpeechUtterance(string: "detta")
            synthesizer.stopSpeaking(at: AVSpeechBoundary.immediate )
            synthesizer.speak(dr)
        case "Etta": let er = AVSpeechUtterance(string: "etta")
            synthesizer.stopSpeaking(at: AVSpeechBoundary.immediate )
            synthesizer.speak(er)
        case "Fetta": let fr = AVSpeechUtterance(string: "fetta")
            synthesizer.stopSpeaking(at: AVSpeechBoundary.immediate )
            synthesizer.speak(fr)
        case "Getta": let gr = AVSpeechUtterance(string: "getta")
            synthesizer.stopSpeaking(at: AVSpeechBoundary.immediate )
            synthesizer.speak(gr)
        case "Hetta": let hr = AVSpeechUtterance(string: "hetta")
            synthesizer.stopSpeaking(at: AVSpeechBoundary.immediate )
            synthesizer.speak(hr)
        case "Itta": let ir = AVSpeechUtterance(string: "itta")
            synthesizer.stopSpeaking(at: AVSpeechBoundary.immediate )
            synthesizer.speak(ir)
        default: print("Hello")
        }
        
    }
    
    
}

func initMarkers() -> [aMarker] {
    return [
        aMarker(id: 0, state: 0, x: 0, y: 0),
        aMarker(id: 1, state: 0, x: 1, y: 0),
        aMarker(id: 2, state: 0, x: 2, y: 0),
        aMarker(id: 3, state: 0, x: 0, y: 1),
        aMarker(id: 4, state: 0, x: 1, y: 1),
        aMarker(id: 5, state: 0, x: 2, y: 1),
        aMarker(id: 6, state: 0, x: 0, y: 2),
        aMarker(id: 7, state: 0, x: 1, y: 2),
        aMarker(id: 8, state: 0, x: 2, y: 2)
    ]
}

struct aMarker: Hashable, Codable, Identifiable {
    var id: Int
    var state : Int
    var x: Int
    var y: Int
}

