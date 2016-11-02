//
//  Critics.swift
//  NYT
//
//  Created by Amber Spadafora on 11/2/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import Foundation

internal enum UserModelParseError: Error {
    case results(json: Any)
    case name(json: AnyObject)
}

class Critic {

    var name: String

    init(name: String) {
        self.name = name
    }
    
    static func createCriticList(from data: Data) -> [Critic]? {
        
        var criticsList: [Critic]? = []
        
        do {
            let jsonData: Any = try JSONSerialization.jsonObject(with: data, options: [])
            
            guard let response: [String: AnyObject] = jsonData as? [String: AnyObject],
                let results: [AnyObject] = response["results"] as? [AnyObject] else {
                    throw UserModelParseError.results(json: jsonData)
            }
            
            for critic in results {
                guard let name: String = critic["display_name"] as? String
                    else {
                        throw UserModelParseError.name(json: critic)
                }
                
                let validCritic: Critic = Critic(name: name)
                criticsList?.append(validCritic)
            }
            return criticsList
            
        }
        
        catch let UserModelParseError.results(json: json) {
            print("Error encountered with parsing 'results' key for object \(json)")
        }
//
        catch let UserModelParseError.name(json: json) {
            print("Error encountered with parsing 'name' key for object \(json)")
        }
//
//        catch let UserModelParseError.location(json: json) {
//            print("Error encountered with parsing 'location' key for object \(json)")
//        }
//            
//        catch let UserModelParseError.login(json: json) {
//            print("Error encountered with parsing 'login' key for object \(json)")
//        }
//            
//        catch let UserModelParseError.picture(json: json) {
//            print("Error encountered with parsing 'login' key for object \(json)")
//        }
//            
        catch {
            print("Error encountered with parsing: \(error)")
        }

        print("returning nil")
        return nil
        
    }
}
