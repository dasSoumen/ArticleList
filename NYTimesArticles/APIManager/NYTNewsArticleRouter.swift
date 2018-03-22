//
//  NYTNewsArticleRouter.swift
//  NYTimesArticles
//
//  Created by Soumen Das on 21/03/18.
//  Copyright © 2018 NYTimes. All rights reserved.
//

import UIKit
import Alamofire
//import SwiftyJSON

enum NYTNewsArticleEndpoint {
    case mostViewd
}

class NYTNewsArticleRouter: NYTBaseRouter {

    var endpoint: NYTNewsArticleEndpoint
    init(endpoint: NYTNewsArticleEndpoint) {
        self.endpoint = endpoint
    }
    
    /// We can configure multiple endpoint here depending on the API end
    override var path: String {
        switch endpoint {
        case .mostViewd:
            return allSectionsSevenDaysEndPoint
        }
    }
    
    override var method: HTTPMethod {
        return .get
    }
}
