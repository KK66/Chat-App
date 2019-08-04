//
//  ResourceModel.swift
//  Brieftauben
//
//  Created by Kilian Kellermann on 25.02.17.
//  Copyright © 2017 Kilian Kellermann. All rights reserved.
//

import Foundation
import Firebase

/* INFO: Anbindung an Firebase. */
class ResourceModel {
    
    // Gibt nur eine einzige Instanz auf dieses Model
    // Von außen nicht mehr instanzierbar. (Singleton Pattern)
    static let sharedInstance = ResourceModel()
    
    private init() {
        FIRApp.configure()
    }
    
    private func getDbReference() -> FIRDatabaseReference {
        return FIRDatabase.database().reference()
    }
    
    // Nachrichten versenden
    func msg(to user: String, withText msg: String) {
        let firebaseRef = getDbReference()
        
        let msgDict = ["recipient": user, "msg": msg]
    
        firebaseRef.child("Messages").childByAutoId().setValue(msgDict)
    }
    
    // Nachrichten abrufen
    func observeMessages(withHandler handler: @escaping (_ message: Message) -> ()) {
        
        let firebaseRef = getDbReference()
        
        firebaseRef.child("Messages").queryOrderedByKey().observe(.childAdded, with: {
            (snapshot) in
            
            let dict = snapshot.value as! NSDictionary
            
            guard let to = dict["recipient"] as? String,
                let msg = dict["msg"] as? String else {
                
                print("Fehler in msg")
                return
            }
            
            let msgObj = Message(to: to, msg: msg)
            handler(msgObj)
        })
    }
}
