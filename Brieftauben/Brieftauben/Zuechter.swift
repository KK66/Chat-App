//
//  Zuechter.swift
//  Brieftauben
//
//  Created by Kilian Kellermann on 25.02.17.
//  Copyright © 2017 Kilian Kellermann. All rights reserved.
//

import Foundation
import Intents

struct Zuechter {
    let name: String
    let email: String
    
    // INPerson zurückgeben.
    func inPerson() -> INPerson? {
        let formatter = PersonNameComponentsFormatter()
        guard let nameComponents = formatter.personNameComponents(from: name) else {
            return nil
        }
        
        let handle = INPersonHandle(value: email, type: .emailAddress)
        
        return INPerson(personHandle: handle, nameComponents: nameComponents, displayName: name, image: nil, contactIdentifier: nil, customIdentifier: nil)
    }
}
