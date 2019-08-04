//
//  Zuechterliste.swift
//  Brieftauben
//
//  Created by Kilian Kellermann on 25.02.17.
//  Copyright © 2017 Kilian Kellermann. All rights reserved.
//

import Foundation

class Zuechterliste {
    
    class func allContacts() -> [Zuechter] {
        let liste = [
            Zuechter(name: "Peter Lustig", email: "peter@lustig.de"),
            Zuechter(name: "Justus Jonas", email: "justus@jonas.de"),
            Zuechter(name: "Paul Panzer", email: "paul@panzer.de")
        ]
        
        return liste
    }
    
    class func allContacts(matching searchstring: String) -> [Zuechter] {
        
        let zuechterliste = allContacts()
        var trefferliste = [Zuechter]()
        
        for match in zuechterliste {
            if match.name.contains(searchstring) {
                trefferliste.append(match)
            }
        }
        
        return trefferliste
    }
}
