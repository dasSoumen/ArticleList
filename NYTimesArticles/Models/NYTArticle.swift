//
//  NYTArticle.swift
//  NYTimesArticles
//
//  Created by Soumen Das on 22/03/18.
//  Copyright © 2018 NYTimes. All rights reserved.
//

import UIKit
import ObjectMapper

class NYTArticle: Mappable {
    
    private var newsURLAsString = ""
    var newsURL: URL? {
        return URL(string: newsURLAsString)
    }
    var adxKeywords = ""
    var byline = ""
    var title = ""
    var abstract = ""
    var publishedDate = ""
    var source = ""
    private var media: Any?
    private var mediaImageURLAsString = ""
    var mediaImageURL: URL? {
        return URL(string: mediaImageURLAsString)
    }
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        newsURLAsString <- map["url"]
        adxKeywords <- map["adx_keywords"]
        byline <- map["byline"]
        title <- map["title"]
        abstract <- map["abstract"]
        publishedDate <- map["published_date"]
        source <- map["source"]
        media <- map["media"]
        /// Check for nil value and fetch the respective image accordingly.
        if media != nil {
            /// As I am not sure about the data type which is coming from the API that's why this checking has been implemented to prevent any crash in case of the wrong data type.
            if let mediaArray = (media as? [[String: AnyObject]]) {
                if mediaArray.count > 0 {
                    if let mediaMetaData = mediaArray[0]["media-metadata"] as? [[String: AnyObject]] {
                        // We are taking only the first index object as we will show only ("format": "square320") the square image from the media-metadata array.
                        if mediaMetaData.count > 0 {
                            mediaImageURLAsString = mediaMetaData[0]["url"] as! String
                        }
                    }
                }
            }
        }
    }
}
