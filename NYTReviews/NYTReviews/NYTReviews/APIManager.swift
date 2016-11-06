//
//  APIManager.swift
//  NYTReviews
//
//  Created by Amber Spadafora on 11/2/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import Foundation

class ApiManager {
    
    static let manager = ApiManager()
    private init() {}
    
    
    let apiEndPoint: URL = URL(string: "https://api.nytimes.com/svc/movies/v2/reviews/search.json?api-key=e23afd8c16ff4c458cb0cc9cce9d815e")!
    
    
//MARK: getReviews Function
    
    func getReviews(callback: @escaping ((Data?) -> Void)) {
        
        let currentURLSession = URLSession(configuration: URLSessionConfiguration.default)
        
        currentURLSession.dataTask(with: ApiManager.manager.apiEndPoint)
        { (data: Data?, response: URLResponse?, error: Error?) in
            
            if error != nil {
                print("There was an error during session: \(error)")
            }
            
            if data != nil {
                callback(data)
            }
            
        } // end bracket for currentURLSession.dataTak closure ((meaning: code from line 25- happens instantly))
        .resume()
    } // end brackett for getReviews (line 19)
    
}
