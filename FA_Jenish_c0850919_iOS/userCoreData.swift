//
//  userCoreData.swift
//  FA_Jenish_c0850919_iOS
//
//  Created by user219793 on 5/30/22.
//

import UIKit
import Foundation
import CoreData

class CoreDataHelper {
    static var instance : CoreDataHelper = CoreDataHelper()
    
    func dataCount() -> Int {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Entity")
        fetchRequest.predicate = NSPredicate(format: "id = %@", "Tic Tac Toe Game")
        
        let manageTxt =
        appDelegate.persistentContainer.viewContext
        do {
            let res = try manageTxt.fetch(fetchRequest)
            if let arr =  res as? [NSManagedObject] {
                return arr.count
            }
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        return 0
    }
    
    
    
    //creating function for store user data inside the core Data
    func saveData(turn : String) {
      
      guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
        return
      }
      
        let manageTxt =
        appDelegate.persistentContainer.viewContext
        
        let objEtity = NSEntityDescription.insertNewObject(forEntityName: "Entity", into: manageTxt) as! Entity
        
        objEtity.turnStart = turn
        objEtity.userID = "Tic Tac Toe Game"
        
        do {
            try manageTxt.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    
    //store game
    func addUsersGame(move : numberMove, turn : String, start : String) {
        let fetchGameRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Entity")
        fetchGameRequest.predicate = NSPredicate(format: "id = %@", "Tic Tac Toe Game")
        
        let manageTxt =
        appDelegate.persistentContainer.viewContext
        do {
            let res = try manageTxt.fetch(fetchGameRequest)
            if let aryA =  res as? [NSManagedObject] {
                if aryA.count != 0 {
                    let managedObject = aryA[0]
                    let obj = managedObject as! Entity
                    if obj.array == nil {
                        var aryMove : [String] = []
                        aryMove.append(move.rawValue)
                        obj.array = aryMove as NSObject
                    } else {
                        var arrImg = obj.array as! [String]
                        arrImg.append(move.rawValue)
                        obj.array = arrImg as NSObject
                    }
                    obj.turnStart = start
                    obj.turnEnd = turn
                    try manageTxt.save()
                }
            }
        } catch let error as NSError {
            print("Could not fetch the User Data. \(error), \(error.userInfo)")
        }
    }
    
    
    //cheking turn and change the turn
    func changeUsersTurn(move : String) {
        let fetchUserRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Entity")
        fetchUserRequest.predicate = NSPredicate(format: "id = %@", "Tic Tac Toe Game")
        
        let manageTxt =
        appDelegate.persistentContainer.viewContext
        do {
            let res = try manageTxt.fetch(fetchUserRequest)
            if let aryA =  res as? [NSManagedObject] {
                if aryA.count != 0 {
                    let managedObject = aryA[0]
                    let obj = managedObject as!
                    Entity
                    obj.turnStart = move
                    try manageTxt.save()
                }
            }
        } catch let error as NSError {
            print("Could not fetch User Data !. \(error), \(error.userInfo)")
        }
    }
    
    
    //function for removing last move
    func removeLastMoveOfUser(turn : String) {
        let fetchUserRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "GameEntity")
        fetchUserRequest.predicate = NSPredicate(format: "id = %@", "Tic Tac Toe Game")
        
        let manageTxt =
        appDelegate.persistentContainer.viewContext
        do {
            let res = try manageTxt.fetch(fetchUserRequest)
            if let aryA =  res as? [NSManagedObject] {
                if aryA.count != 0 {
                    let managedObject = aryA[0]
                    let obj = managedObject as! Entity
                    if obj.array != nil {
                        var arrImg = obj.array as! [String]
                        arrImg.removeLast()
                        obj.array = arrImg as NSObject
                    }
                    obj.turnStart = turn
                    try manageTxt.save()
                }
            }
        } catch let error as NSError {
            print("Could not fetch User. \(error), \(error.userInfo)")
        }
    }
    
    
    
    func updateCircle(count : Int) {
        let fetchUserRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Entity")
        fetchUserRequest.predicate = NSPredicate(format: "id = %@", "Tic Tac Toe Game")
        
        let manageTxt =
        appDelegate.persistentContainer.viewContext
        do {
            let res = try manageTxt.fetch(fetchUserRequest)
            if let aryA =  res as? [NSManagedObject] {
                if aryA.count != 0 {
                    let managedObject = aryA[0]
                    let obj = managedObject as! Entity
                    obj.scoreOfO = Double(count)
                    try manageTxt.save()
                }
            }
        } catch let error as NSError {
            print("Could not fetch User. \(error), \(error.userInfo)")
        }
    }
    
    func updateCross(count : Int) {
        let fetchUserRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Entity")
        fetchUserRequest.predicate = NSPredicate(format: "id = %@", "Tic Tac Toe Game")
        
        let manageTxt =
        appDelegate.persistentContainer.viewContext
        do {
            let res = try manageTxt.fetch(fetchUserRequest)
            if let aryA =  res as? [NSManagedObject] {
                if aryA.count != 0 {
                    let managedObject = aryA[0]
                    let obj = managedObject as! Entity
                    var arrMoves = obj.array as! [String]
                    arrMoves.removeAll()
                    obj.scoreOfX = Double(count)
                    obj.array = arrMoves as NSObject
                    try manageTxt.save()
                }
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func userGameData() {
        appDelegate.AryGame.removeAll()
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let manageTxt = appDelegate.persistentContainer.viewContext
        let fetchUserRequest = NSFetchRequest<NSManagedObject>(entityName: "Entity")
        
        do {
            appDelegate.AryGame = try manageTxt.fetch(fetchUserRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func resetUserData() {
        let fetchUserRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "GameEntity")
        fetchUserRequest.predicate = NSPredicate(format: "id = %@", "Tic Tac Toe Game")
        
        let manageTxt =
        appDelegate.persistentContainer.viewContext
        do {
            let res = try manageTxt.fetch(fetchUserRequest)
            if let aryA =  res as? [NSManagedObject] {
                if aryA.count != 0 {
                    let managedObject = aryA[0]
                    manageTxt.delete(managedObject)
                    try manageTxt.save()
                }
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
}

