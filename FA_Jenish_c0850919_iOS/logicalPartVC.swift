//
//  logicalPartVC.swift
//  FA_Jenish_c0850919_iOS
//
//  Created by user219793 on 5/27/22.
//

import UIKit

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
                self.circleWinerCounter.text = "Score  : \(self.defaultCircle)"
                self.crossWinerCounter.text = "Score  : \(self.defaultCross)"
            }))
            self.present(alertCont, animated: true)
            
            
            
            //case for left swipe
        case .left:
            
            print("Left Swipe gesture recognized")
            
            let passMessage = "do you want to Reset?"
            
            //apllaying alertcontrollar for controlling the alert
            let alertCont = UIAlertController(title: "By reseting the Board you will loose your on going board !", message: passMessage, preferredStyle: .actionSheet)
            alertCont.addAction(UIAlertAction(title: "Please Confirm!", style: .default, handler: {
                (_) in self.resetBoard()//reseting the board
                self.defaultCross = 0 // than reseting the score
                self.defaultCircle = 0
                
                //than reseting the score from scorreboard as well
                self.circleWinerCounter.text = "Score  : \(self.defaultCircle)"
                self.crossWinerCounter.text = "Score  : \(self.defaultCross)"
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
      
        print("Shake Gesture Recognized !!")
       
        
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
    
    //function that will check the victory
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
        
        
        
        
        
        //now applay for victory conditions for Vertical
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
    
    //Creating funation called applaytoboard that will recive the sender
    func applaytoboard(_ sender: UIButton)
    {
        if(sender.title(for: .normal) == nil)
        {
            if(currentTurn == letTurn.circle)
            {
                sender.setTitle(Circle, for: .normal)
                currentTurn = letTurn.cross
                showCurrentTurn.text = Cross
            }
            else if(currentTurn == letTurn.cross)
            {
                sender.setTitle(Cross, for: .normal)
                currentTurn = letTurn.circle
                showCurrentTurn.text = Circle
            }
            sender.isEnabled = false
        }
    }
   
    
   

}
