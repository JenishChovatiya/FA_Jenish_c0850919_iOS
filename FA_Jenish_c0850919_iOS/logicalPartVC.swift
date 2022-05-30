//
//  logicalPartVC.swift
//  FA_Jenish_c0850919_iOS
//
//  Created by user219793 on 5/27/22.
//

import UIKit

//creating enum for core data
enum numberMove : String
{
    case first
    case second
    case third
    case forth
    case fifth
    case sixth
    case seventh
    case eighth
    case ninth
}

class logicalPartVC: UIViewController
{

    //declaring enum
    enum letTurn
    {
        case cross
        case circle
        
        
    }
    
    //linking the lable to the view controller
    @IBOutlet weak var showCurrentTurn: UILabel!
    
    //linking the buttons
    @IBOutlet weak var first: UIButton!
    @IBOutlet weak var second: UIButton!
    @IBOutlet weak var third: UIButton!
    @IBOutlet weak var forth: UIButton!
    @IBOutlet weak var fifth: UIButton!
    @IBOutlet weak var sixth: UIButton!
    @IBOutlet weak var seventh: UIButton!
    @IBOutlet weak var eighth: UIButton!
    @IBOutlet weak var ninth: UIButton!
    
    
    //connecting two lables that is displaying the score
    @IBOutlet weak var crossWinerCounter: UILabel!
    @IBOutlet weak var circleWinerCounter: UILabel!
    
    
    
    //declaring some variables
    var turnone = letTurn.cross
    var currentTurn = letTurn.cross
    
    
    //declaring varible
    
    var buttonArray:[Int] = []
    
    var Circle = "O"
    var Cross = "X"
    var board = [UIButton]()
    
   
 
    
    //declaring default score of cross and circle as 0
    var defaultCross = 0
    var defaultCircle = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //connecting with core data
        //applying first if else condition
        if CoreDataHelper.instance.dataCount() == 0
        {
            CoreDataHelper.instance.saveData(turn: "X")
        } else {
            CoreDataHelper.instance.userGameData()
            if appDelegate.AryGame.count != 0  {
                let objGame = appDelegate.AryGame[0] as! Entity
                showCurrentTurn.text = objGame.turnStart ?? ""
                if let arrMoves = objGame.array as? [String] {
                    
                    defaultCross = Int(objGame.scoreOfX)
                    defaultCircle = Int(objGame.scoreOfO)
                    var currentMove = objGame.turnStart ?? "X"
                    for i in 0..<arrMoves.count {
                        let btnName = arrMoves[i]
                        if btnName == "first" {
                            first.setTitle(currentMove, for: .normal)
                        } else if btnName == "second" {
                            second.setTitle(currentMove, for: .normal)
                        } else if btnName == "third" {
                            third.setTitle(currentMove, for: .normal)
                        } else if btnName == "forth" {
                            forth.setTitle(currentMove, for: .normal)
                        } else if btnName == "fifth" {
                            fifth.setTitle(currentMove, for: .normal)
                        } else if btnName == "sixth" {
                            sixth.setTitle(currentMove, for: .normal)
                        } else if btnName == "seventh" {
                            seventh.setTitle(currentMove, for: .normal)
                        } else if btnName == "eighth" {
                            eighth.setTitle(currentMove, for: .normal)
                        } else if btnName == "ninth" {
                            ninth.setTitle(currentMove, for: .normal)
                        }
                        currentTurn = userNextMoveEnum(turnmove: currentMove)
                        currentMove = userTurnMove(turnmove: currentMove)
                        showCurrentTurn.text = currentMove
                    }
                }
                circleWinerCounter.text = String(Int(objGame.scoreOfO))
                crossWinerCounter.text = String(Int(objGame.scoreOfX))
            }
            
            
            
        }
        
        
        initializetheboard()
        
        
    }
    
    
    
    
    //MARK: implementing Swip gesture for reseting the game
    @IBAction func swipeGestureRecognize(_ sender: UISwipeGestureRecognizer)
    {
        //applaying switch case for recognizing  direction and baed on it applaying condition's for reset the board
        switch sender.direction
        {
            
            //case for right swipe
        case .right:
            
            print("Right Swipe gesture recognized")
            
            
            let passMessage = "do you want to Reset?"
            
            //apllaying alertcontrollar for controlling the alert
            let alertCont = UIAlertController(title: "By reseting the Board you will loose your on going board !", message: passMessage, preferredStyle: .actionSheet)
            alertCont.addAction(UIAlertAction(title: "Please Confirm!", style: .default, handler: {
                (_) in self.resetBoard()//reset the board
                self.defaultCross = 0//reset the score
                self.defaultCircle = 0
                
                //reset the score from board as well
                self.circleWinerCounter.text = "\(self.defaultCircle)"
                self.crossWinerCounter.text = " \(self.defaultCross)"
            }))
            self.present(alertCont, animated: true)
            
            
        default:
            print("Something wrong")
            break

            
        }
    }
    
   
    
    
    //MARK: creating function for shake gesture recognizer for undo user's move
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?)
    {
      
        if let _ = buttonArray.last
        {
            if motion == .motionShake
            {
                print("Shake Gesture Recognized !!")
                
                //applaying undo function
                
                performUndoOperation()
                
                
                var tempdisplay = ""
                if(currentTurn == letTurn.circle)
                {
                    currentTurn = letTurn.cross
                    showCurrentTurn.text = Cross
                    tempdisplay = "X"
                }
                else if (currentTurn == letTurn.cross)
                {
                    currentTurn = letTurn.circle
                    showCurrentTurn.text = Circle
                    tempdisplay = "O"
                }
                CoreDataHelper.instance.removeLastMoveOfUser(turn: tempdisplay)
            }
        }
       
       
        
    }
    
    //MARK: Creating Undo function
    func performUndoOperation()
    {
        if let tglast = buttonArray.last
        {
            if(tglast == 1)
            {
                first.setTitle(nil, for: .normal)
                first.isEnabled = true
            }
            else if (tglast == 2)
            {
                second.setTitle(nil, for: .normal)
                second.isEnabled = true
            }
            else if (tglast == 3)
            {
                third.setTitle(nil, for: .normal)
                third.isEnabled = true
            }
            else if (tglast == 4)
            {
                forth.setTitle(nil, for: .normal)
                forth.isEnabled = true
            }
            else if (tglast == 5)
            {
                fifth.setTitle(nil, for: .normal)
                fifth.isEnabled = true
            }
            else if (tglast == 6)
            {
                sixth.setTitle(nil, for: .normal)
                sixth.isEnabled = true
            }
            else if (tglast == 7)
            {
                seventh.setTitle(nil, for: .normal)
                seventh.isEnabled = true
            }
            else if (tglast == 8)
            {
                eighth.setTitle(nil, for: .normal)
                eighth.isEnabled = true
            }
            else if (tglast == 9)
            {
                ninth.setTitle(nil, for: .normal)
                ninth.isEnabled = true
            }
            buttonArray.removeLast()
        }
    }
    
    
    
    
    //creating some functions regarding database
    func userTurnMove(turnmove : String) -> String
    {
        if turnmove == "X"
        {
            return "O"
        }
        else
        {
            return "X"
        }
    }
    
    func userNextMoveEnum(turnmove : String) -> letTurn
    {
        if turnmove == "X"
        {
            return letTurn.circle
            
        }
        else
        {
            return letTurn.cross
        }
    }
    
    
    
    
    
    //MARK: creating action that will respones when user will touch any of the button
    @IBAction func tapAction(_ sender: UIButton)
    {
        applaytoboard(sender)
        
        if checkUserWin(Cross)
        {
            defaultCross += 1
            alertForResult(title: "X is the winer")
            crossWinerCounter.text = "\(defaultCross)"
            
        }
        
        if checkUserWin(Circle)
        {
            
            defaultCircle += 1
            alertForResult(title: "O is the winer")
            circleWinerCounter.text = "\(defaultCircle)"
            
        }
        
        if(whenboardfull())
        {
            alertForResult(title: "It's Draw !!")
        }
    }
    
    
    
    //MARK: function that will check the victory
    func checkUserWin(_ s :String) -> Bool
    {
        
        
        //now applay for victory conditions for Horizontal
        if symbol(first, s) && symbol(second, s) && symbol(third, s)
        {
            return true
        }
        if symbol(forth, s) && symbol(fifth, s) && symbol(sixth, s)
        {
            return true
        }
        if symbol(seventh, s) && symbol(eighth, s) && symbol(ninth, s)
        {
            return true
        }
        
     
       
        
        
        
        
        //MARK: now applay for victory conditions for Vertical
        if symbol(first, s) && symbol(forth, s) && symbol(seventh, s)
        {
            return true
        }
        if symbol(second, s) && symbol(fifth, s) && symbol(eighth, s)
        {
            return true
        }
        if symbol(third, s) && symbol(sixth, s) && symbol(ninth, s)
        {
            return true
        }
        
        
        
        
        //now applaing for diagnal Victory
        if symbol(first, s) && symbol(fifth, s) && symbol(ninth, s)
        {
            return true
        }
        if symbol(third, s) && symbol(fifth, s) && symbol(seventh, s)
        {
            return true
        }
        
        return false
        
    }
    
    
    
    
    func symbol(_ button: UIButton, _ symbol: String) -> Bool
    {
        return button.title(for: .normal) == symbol
    }
    
    
    
    
    //MARK: displaying result
    func alertForResult(title: String)
    {
        //displaying winner either circle or cross in alert box
        let controllingtoAlert = UIAlertController(title: title, message: nil, preferredStyle: .actionSheet)
        
        controllingtoAlert.addAction(UIAlertAction(title: "Reset the Board", style: .default, handler: { (_) in self.resetBoard()
        }))
        self.present(controllingtoAlert, animated: true)
    }
    
    
    
    
    
    //MARK: this function will use to reset the board
    func resetBoard()
    {
        for button in board
        {
            button.setTitle(nil, for: .normal)
            button.isEnabled = true
        }
        if(turnone == letTurn.circle)
        {
            turnone = letTurn.cross
            showCurrentTurn.text = Cross
        }
        else if(turnone == letTurn.cross)
        {
            turnone = letTurn.circle
            showCurrentTurn.text = Circle
            
        }
        currentTurn = turnone
      
    }
    
    
    
 
    //this function will execute if non of any user win and non of any block is left to paly
    func whenboardfull() -> Bool
    {
        for button in board
        {
            //if anythinf fill find empty space
            if button.title(for: .normal)  == nil
            {
                return false
            }
            
        }
        return true
    }
    
    
    
    
    //MARK: add in the array of board
    func initializetheboard()
    {
        first.tag = 1
        second.tag = 2
        third.tag = 3
        forth.tag = 4
        fifth.tag = 5
        sixth.tag = 6
        seventh.tag = 7
        eighth.tag = 8
        ninth.tag = 9
        
        
        board.append(first)
        board.append(second)
        board.append(third)
        board.append(forth)
        board.append(fifth)
        board.append(sixth)
        board.append(seventh)
        board.append(eighth)
        board.append(ninth)
        
        
    }
    
    
    
    func takeMove(index : Int) -> numberMove
    {
        var mo = numberMove.first
        if index == 1
        {
            mo = .first
        }
        else if(index == 2)
        {
            mo = .second
        }
        else if(index == 3)
        {
            mo = .third
        }
        else if(index == 4)
        {
            mo = .forth
        }
        else if(index == 5)
        {
            mo = .fifth
        }
        else if(index == 6)
        {
            mo = .sixth
        }
        else if(index == 7)
        {
            mo = .seventh
        }
        else if(index == 8)
        {
            mo = .eighth
        }
        else if(index == 9)
        {
            mo = .ninth
        }
        return mo
    }
    
    
    
    //Creating funation called applaytoboard that will recive the sender
    func applaytoboard(_ sender: UIButton)
    {
        if(sender.title(for: .normal) == nil)
        {
            var tempTurn = ""
            if(currentTurn == letTurn.circle)
            {
                sender.setTitle(Circle, for: .normal)
                currentTurn = letTurn.cross
                showCurrentTurn.text = Cross
                tempTurn = "X"
            }
            else if(currentTurn == letTurn.cross)
            {
                sender.setTitle(Cross, for: .normal)
                currentTurn = letTurn.circle
                showCurrentTurn.text = Circle
                tempTurn = "O"
            }
            sender.isEnabled = false
            buttonArray.append(sender.tag)
            
            var playTurn = ""
            if turnone == .cross
            {
                playTurn = "X"
            }
            else
            {
                playTurn = "O"
            }
            CoreDataHelper.instance.addUsersGame(move: takeMove(index: sender.tag), turn: tempTurn, start: playTurn)
        }
        
    }
   

   

}
