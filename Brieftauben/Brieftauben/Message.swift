//
//  Message.swift
//  Brieftauben
//
//  Created by Kilian Kellermann on 25.02.17.
//  Copyright © 2017 Kilian Kellermann. All rights reserved.
//

import Foundation

/* INFO: Data-Model für die Nachrichten. */
class Message {
    let to: String
    let msg: String
    
    init(to: String, msg: String) {
        self.to = to
        self.msg = msg
    }
    
    func getTo() -> String {
        return to
    }
    
    func getMsg() -> String {
        return msg
    }
}
