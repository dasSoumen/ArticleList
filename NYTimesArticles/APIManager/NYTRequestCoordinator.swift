//
//  NYTRequestCoordinator.swift
//  NYTimesArticles
//
//  Created by Soumen Das on 21/03/18.
//  Copyright © 2018 NYTimes. All rights reserved.
//

import UIKit
import ObjectMapper
import SwiftyJSON

final class NYTRequestCoordinator: NSObject {
    static let coordinator = NYTRequestCoordinator()
    private override init() {
    }
}

typealias NYTNewsArticleRequestCoordinator = NYTRequestCoordinator
extension NYTNewsArticleRequestCoordinator {
    
    func getMostPopularArticles(withSuccess success:@escaping (_ response: [NYTArticle]?) -> Void, andFailure failure:@escaping (_ error: Error?) -> Void) {
        NYTAPIManager.manager.request(withRouter: NYTNewsArticleRouter(endpoint: .mostViewd), shouldShowLoader: true, shouldShowToast: true, withSuccess: { response in
            var articles = [NYTArticle]()
            // Nil checking has been incorporated if incase "results" key is not present there.
            if response.dictionaryObject!["results"] != nil {
                let responseArray = response.dictionaryObject!["results"] as! [[String : Any]]
                // array of NYTArticle will be created
                articles = Mapper<NYTArticle>().mapArray(JSONArray: responseArray)
            }
            success(articles)
        }) { error in
            failure(error)
        }
    }
}
