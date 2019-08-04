//
//  IntentHandler.swift
//  Siri Extension
//
//  Created by Kilian Kellermann on 25.02.17.
//  Copyright © 2017 Kilian Kellermann. All rights reserved.
//

import Intents

// As an example, this class is set up to handle Message intents.
// You will want to replace this or add other intents as appropriate.
// The intents you wish to handle must be declared in the extension's Info.plist.

// You can test your example integration by saying things to Siri like:
// "Send a message using <myApp>"
// "<myApp> John saying hello"
// "Search for messages in <myApp>"

class IntentHandler: INExtension, INSendMessageIntentHandling {
    
    override func handler(for intent: INIntent) -> Any {
        
        return self
    }
    
    // resolve
    func resolveRecipients(for intent: INSendMessageIntent, with completion: @escaping ([INPersonResolutionResult]) -> Void) {
        guard let recipients = intent.recipients else {
            completion([INPersonResolutionResult.needsValue()])
            return
        }
        
        var resolutionResult = [INPersonResolutionResult]()
        
        for recipient in recipients {
            
            let matchingContacts = Zuechterliste.allContacts(matching: recipient.displayName)
            
            switch matchingContacts.count {
            case 2...Int.max:
                let disambiguationOptions: [INPerson] = matchingContacts.map {
                    zuechter in
                    
                    return zuechter.inPerson()!
                }
                
                resolutionResult = [INPersonResolutionResult.disambiguation(with: disambiguationOptions)]

            case 1:
                if let recipientMatch = matchingContacts[0].inPerson() {
                    resolutionResult = [INPersonResolutionResult.success(with: recipientMatch)]
                }
                
            case 0:
                resolutionResult = [INPersonResolutionResult.unsupported()]
                
            default:
                break
            }
        }
        
        completion(resolutionResult)
    }
    
    // content
    func resolveContent(for intent: INSendMessageIntent, with completion: @escaping (INStringResolutionResult) -> Void) {
        
        guard let content = intent.content else {
            let response = INStringResolutionResult.needsValue()
            completion(response)
            
            return
        }
        
        let response = INStringResolutionResult.success(with: content)
        completion(response)
    }
    
    // confirm
    func confirm(intent: INSendMessageIntent, completion: @escaping (INSendMessageIntentResponse) -> Void) {
        
        var isLoggedIn = true
        // ...
        // login / usw
        
        if isLoggedIn {
            completion(INSendMessageIntentResponse(code: .success, userActivity: nil))
        } else {
            // ...
            completion(INSendMessageIntentResponse(code: .failureRequiringAppLaunch, userActivity: nil))
        }
    }
    
    /*!
     @brief handling method
     
     @abstract Execute the task represented by the INSendMessageIntent that's passed in
     @discussion This method is called to actually execute the intent. The app must return a response for this intent.
     
     @param  sendMessageIntent The input intent
     @param  completion The response handling block takes a INSendMessageIntentResponse containing the details of the result of having executed the intent
     
     @see  INSendMessageIntentResponse
     */
    public func handle(intent: INSendMessageIntent, completion: @escaping (INSendMessageIntentResponse) -> Void) {
        
        let dbResource = ResourceModel.sharedInstance
        
        if let recipientList = intent.recipients, let content = intent.content {
            for recipient in recipientList {
                dbResource.msg(to: recipient.displayName, withText: content)
            }
            
            completion(INSendMessageIntentResponse(code: .success, userActivity: nil))
        } else {
            completion(INSendMessageIntentResponse(code: .failure, userActivity: nil))
        }
    }
}

