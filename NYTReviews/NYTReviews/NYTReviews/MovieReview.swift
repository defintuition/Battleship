//
//  MovieReview.swift
//  NYTReviews
//
//  Created by Amber Spadafora on 11/2/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import Foundation

internal enum DataParseError: Error {
    case displayTitle
    case results
}

class movieReview {
    
    var displayTitle: String // "The Eagle Huntress",
    
    var mpaaRating: String //"G",

    var criticsPick: Int //1,

    var byline: String // "A. O. SCOTT",
    
    var headline: String // "Review: In ‘The Eagle Huntress,’ a Girl From Mongolia Soars",
    
    var summaryShort: String
    // "A teenager from a nomadic family bucks gender norms by raising a bird and training it to hunt in this documentary.",
    
    var publicationDate: String // "2016-11-01",
    
    var imageSrc: String
    var imageHeight: Int
    var imageWidth: Int
    
    var articleUrl: String
    var articleLinkText: String
    
    var imageDic: [String: AnyObject]
    
 // link: [String: String] //
//    "type": "article",
//    "url": "http://www.nytimes.com/2016/11/02/movies/the-eagle-huntress-review.html",
//    "suggested_link_text": "Read the New York Times Review of The Eagle Huntress"
    
    // multimedia: [String: AnyObject]
//    "multimedia": 
//      "type": "mediumThreeByTwo210",
//      "src": "urllinkgoeshere"
//      "width": 210,
//      "height": 140
    
    
    
    init(displayTitle: String, mpaaRating: String, criticsPick: Int, byline: String, headline: String, summaryShort: String, publicationDate: String, articleUrl: String, articleLinkText: String, imageSrc: String, imageHeight: Int, imageWidth: Int, imageDic: [String: AnyObject]) {
        
        self.displayTitle = displayTitle
        self.mpaaRating = mpaaRating
        self.criticsPick = criticsPick
        self.byline = byline
        self.headline = headline
        self.summaryShort = summaryShort
        self.publicationDate = publicationDate
        self.articleUrl = articleUrl
        self.articleLinkText = articleLinkText
        self.imageSrc = imageSrc
        self.imageHeight = imageHeight
        self.imageWidth = imageWidth
        self.imageDic = imageDic
        
    }
    
    convenience init?(from dictionary: [String: AnyObject]) throws {
        var imageSrc = String()
        var imageHeight = Int()
        var imageWidth = Int()
        
        var articleUrl = String()
        var articleLinkText = String()
        
        
        guard let displayTitle = dictionary["display_title"] as? String else {
            throw DataParseError.displayTitle
        }
        
        guard let mpaaRating = dictionary["mpaa_rating"] as? String else {
            throw DataParseError.displayTitle
        }
        
        guard let critics_pick = dictionary["critics_pick"] as? Int else {
            throw DataParseError.displayTitle
        }
        
        guard let byline = dictionary["byline"] as? String else {
            throw DataParseError.displayTitle
        }
        
        guard let headline = dictionary["headline"] as? String else {
            throw DataParseError.displayTitle
        }
        
        guard let summaryShort = dictionary["summary_short"] as? String else {
            throw DataParseError.displayTitle
        }
        
        guard let publicationDate = dictionary["publication_date"] as? String else {
            throw DataParseError.displayTitle
        }
        
        guard let image = dictionary["multimedia"] as? [String: AnyObject] else {
            throw DataParseError.displayTitle
        }
        
        if let link = dictionary["link"] as? [String: AnyObject],
        let linkInfo = link["linkInfo"] as? [String: String] {
            articleUrl = linkInfo["url"]! as String
            articleLinkText = linkInfo["suggested_link_text"]! as String
        }
        
        imageSrc = image["src"] as! String
        imageWidth = image["width"] as! Int
        imageHeight = image["height"] as! Int
        
        self.init(displayTitle: displayTitle, mpaaRating: mpaaRating, criticsPick: critics_pick,
                  byline: byline, headline: headline, summaryShort: summaryShort, publicationDate: publicationDate, articleUrl: articleUrl, articleLinkText: articleLinkText, imageSrc: imageSrc, imageHeight: imageHeight, imageWidth: imageWidth, imageDic: image)
    } // end of Convenience Initializer
    
    
    static func createArrayOfReviews(from data: Data) -> [movieReview]? {
        var reviewsList: [movieReview]? = []
        
        do {
            let jsonData: Any = try JSONSerialization.jsonObject(with: data, options: [])
            
            guard let response: [String: AnyObject] = jsonData as? [String: AnyObject],
            let results = response["results"] as? [[String: AnyObject]]
                else {
                    throw DataParseError.results
            }
            
            for review in results {
                let validReview: movieReview = try movieReview(from: review)!
                reviewsList?.append(validReview)
            }
        }
        
        catch DataParseError.results {
            print("Error encountered with parsing 'results' key")
        }
        catch DataParseError.displayTitle {
            print("Error encountered with parsing 'results' key values")
        }
        catch {
            print("error encountered")
        }
        return reviewsList
        
    }
    
    func getImage(from image: String, callback: @escaping (Data) -> () ) {
        guard let imageURL = URL(string: image) else {
            return
        }
        
        let urlSession = URLSession(configuration: URLSessionConfiguration.default)
        
        urlSession.dataTask(with: imageURL) { (data: Data?, response: URLResponse?, error: Error?) in
        
            if error != nil {
                print("There was an error during session: \(error)")
            }
            
            guard let validImageData = data else { return }
            callback(validImageData)
        }
        .resume()
    }
    
}






























