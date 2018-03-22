//
//  NYTMostViewedTableViewCell.swift
//  NYTimesArticles
//
//  Created by Soumen Das on 22/03/18.
//  Copyright © 2018 NYTimes. All rights reserved.
//

import UIKit
import AlamofireImage

class NYTMostViewedTableViewCell: NYTBaseTableViewCell {
    // MARK: - IBOutlets
    @IBOutlet private weak var imageIcon: UIImageView!
    @IBOutlet private weak var labelDescription: UILabel!
    @IBOutlet private weak var labelPostedBy: UILabel!
    @IBOutlet private weak var labelDate: UILabel!
    
    // MARK: - UI representation
    var datasource: NYTArticle? {
        didSet {
            labelDescription.text = datasource!.title
            labelPostedBy.text = datasource!.byline
            labelDate.text = datasource!.publishedDate
            imageIcon.af_setImage(withURL: datasource!.mediaImageURL!, placeholderImage: nil, filter: nil, progress: nil, progressQueue: .main, imageTransition: .crossDissolve(0.3), runImageTransitionIfCached: false, completion: nil)
        }
    }
}
