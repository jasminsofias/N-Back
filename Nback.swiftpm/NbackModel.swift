

import Foundation

struct NbackModel {
    var currentPlayer = 1 // cross
    var gameState = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    var lastGameState = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    var gameIsActive = true
    var count = 1
    var matches = 0
    var check = 0
    let winningCombinations = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
    let letters = ["Atta", "Betta", "Cetta", "Detta", "Etta", "Fetta", "Getta", "Hetta", "Itta"]
    var letterState = ["", "", "", "", "", "", "", "", ""] as [String] 
    var lastLetterState = ["", "", "", "", "", "", "", "", ""] as [String]
    
    mutating func resetGame(){
        gameState = [0, 0, 0, 0, 0, 0, 0, 0, 0]
        gameIsActive = true
        currentPlayer = 1
        count = 1;
    }
    
    mutating func resetRound(){
        gameState = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    }
    
    func getRandomInt() -> Int{
        return Int.random(in:1..<8)
    } 
    
    func getRandomLetter() -> String{
        let randomLetter = letters.randomElement()!
        return randomLetter
    }
    
    mutating func aMove(position: Int) -> Int{
        if gameState[position] == 0 && gameIsActive == true{
            print(lastGameState)
            gameState[position] = currentPlayer 
            if(checkSim(last: lastGameState, current: gameState)){
               matches += 1
                check = 1
            }else{
                check = 0
            }  
            count = count + 1;
            lastGameState = gameState
            print(gameState)
            return 1
        }
        return 0
    }
    
    mutating func aSound(position: Int) -> (pos: Int, letter: String){
        if gameIsActive == true{
            print(lastLetterState)
            let le = getRandomLetter()
            letterState[position] = le
            if(isMatch(last: lastLetterState, current: letterState)){
                matches += 1
                check = 1
            }else{
                check = 0
            }
            count = count + 1
            lastLetterState = letterState
            print(letterState)
            return (1, le); 
        }
        return (0, "")
    }
    
    func isMatch(last: [String], current:[String] ) -> Bool{
        if(last == current){
            return true
        }
        return false
    }
    
    mutating func checkSim(last: [Int], current: [Int]) -> Bool{
        if(last == current){
            return true
        }
        return false
    }
    
    
    func getTile(position: Int) -> Int{
        return gameState[position];
    }
    func isRight() -> Bool{
        if check == 1{
            return true
        }
        return false
    }
    
    mutating func checkWinner() -> Int{
        for combination in winningCombinations {
            if gameState[combination[0]] != 0 && gameState[combination[0]] == gameState[combination[1]] && gameState[combination[1]] == gameState[combination[2]]{
                gameIsActive = false
                
                if gameState[combination[0]] == 1{
                    return 1
                }else{
                    return 2
                }
            }
        }
        
        if gameIsActive == true && count > 9{
            gameIsActive = false
            return 3
        }
        return 0
    }
}
