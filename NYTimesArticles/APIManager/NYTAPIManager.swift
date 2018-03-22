//
//  NYTAPIManager.swift
//  NYTimesArticles
//
//  Created by Soumen Das on 21/03/18.
//  Copyright © 2018 NYTimes. All rights reserved.
//

import UIKit
import Reqres
import Alamofire
import SwiftyJSON

func += <K, V> (left: inout [K: V], right: [K: V]) {
    for (k, v) in right {
        left.updateValue(v, forKey: k)
    }
}

struct APIError: Error {
    var errorCode: Int?
    var errorDetails: String?
}

// MARK: Reachability Check
private let network = NetworkReachabilityManager()
private func isReachable() -> (Bool) {
    if network?.isReachable ?? false {
        if (network?.isReachableOnEthernetOrWiFi) != nil {
            return true
        } else if (network?.isReachableOnWWAN)! {
            return true
        }
    } else {
        return false
    }
    return false
}

/**
 Creating network listener function which will inform us about the network connection and disconnection every time.
 */

// MARK: Start Listener
func startListening() {
    network?.startListening()
    network?.listener = { status in
        if status == .notReachable {
            //NotificationCenter.default.post(name: Notification.Name(rawValue: networkUnreachable), object: nil)
        } else if status == .reachable(.ethernetOrWiFi) || status == .reachable(.wwan) {
            //NotificationCenter.default.post(name: Notification.Name(rawValue: networkReachable), object: nil)
        }
    }
}

class NYTAPIManager: SessionManager {
    
    /// Creating the singleton instance of the APIManager class.
    static let manager: NYTAPIManager = {
        let configuration = Reqres.defaultSessionConfiguration()
        configuration.timeoutIntervalForRequest = 120
        configuration.httpMaximumConnectionsPerHost = 1
        let manager = NYTAPIManager(configuration: configuration)
        return manager
    }()
    
    // MARK: API Request
    func request(withRouter router: NYTBaseRouter, isUserInteractionEnabled userInteractionEnabled: Bool = true, shouldShowLoader loaderEnabled: Bool = false, shouldShowToast toastEnabled: Bool = true, withSuccess success:@escaping (_ decryptedJSONString: JSON) -> Void, andFailure failure:@escaping (_ error: Error?) -> Void) {
        
        guard isReachable() else {
            let error = APIError(errorCode: -200, errorDetails: noNetworkText)
            failure(error)
            return
        }
        
        loaderEnabled ? NYTHelper.helper.showLoader() : debugPrint("Loader not enabled")
        !userInteractionEnabled ? NYTHelper.helper.showClearView() : debugPrint("User interaction enabled")
        NYTAPIManager.manager.request(router).validate().responseJSON { (response) in
            if loaderEnabled {
                DispatchQueue.main.async {
                    NYTHelper.helper.hideLoader()
                }
            }
            !userInteractionEnabled ? NYTHelper.helper.hideClearView() : debugPrint("User interaction was enabled")
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                guard json["status"].stringValue == successResponseStatus else {
                    let error = APIError(errorCode: 700, errorDetails: noData)
                    failure(error)
                    return
                }
                success(json)
            case .failure(let error):
                toastEnabled ? NYTToast.show(withText: error.localizedDescription, position: .middle) : debugPrint("Toast not enabled")
                failure(error)
            }
        }
    }
}
