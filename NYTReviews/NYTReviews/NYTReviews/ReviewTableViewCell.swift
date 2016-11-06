//
//  ReviewTableViewCell.swift
//  NYTReviews
//
//  Created by Amber Spadafora on 11/4/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

class ReviewTableViewCell: UITableViewCell {

    @IBOutlet weak var reviewImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setData(movieReview: movieReview){
        
        movieReview.getImage(from: movieReview.imageSrc) { (data: Data) in
            
            DispatchQueue.main.async {
                self.reviewImage.image = UIImage(data: data)
                self.setNeedsLayout()
            }
        }
        
        self.textLabel?.text = movieReview.displayTitle
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
