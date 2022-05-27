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
    
    
    //declaring some variables
    var turnone = letTurn.cross
    var currentTurn = letTurn.cross
    
    
    //declaring varible that will diplay when we will call
    var Circle = "O"
    var Cross = "X"
    var board = [UIButton]()
    
    
    //declaring default score of cross and circle as 0
    var defaultCross = 0
    var defaultCircle = 0
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
    
    //creating action that will respones when user will touch any of the button
    
    @IBAction func tapAction(_ sender: UIButton)
    {
       
    }
    
   

}
