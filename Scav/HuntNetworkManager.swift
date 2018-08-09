//
//  HuntNetworkManager.swift
//  Scav
//
//  Created by Mayki Hu on 7/27/18.
//  Copyright © 2018 GirlsWhoCode. All rights reserved.
//

import Foundation

class HuntNetworkManager {
    
    static let shared = HuntNetworkManager()
    
    private var tasks = [URLSessionDataTask]()
    
    private enum HTTPMethod: String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case delete = "DELETE"
    }
    
    enum Request {
        case getHunts
        case createHunt(hunt: Hunt)
        
        private var baseURLString: String {
            return "https://iac-gwc-scav.herokuapp.com"
        }
        
        private var urlString: String {
            switch self {
            case .getHunts, .createHunt:
                return "/hunts"
            }
        }
        
        private var method: HTTPMethod {
            switch self {
            case .getHunts:
                return .get
            case .createHunt:
                return .post
            }
        }
        
        private var body: Data? {
            switch  self {
            case .createHunt(let hunt):
                return hunt.serialize()
            default:
                return nil
            }
        }
        
        var request: URLRequest {
            let url = URL(string: baseURLString + urlString)!
            var req = URLRequest(url: url)
            
            req.httpMethod = method.rawValue
            req.httpBody = body
        
            return req
        }
        
    }

    func process(_ request: Request, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request.request, completionHandler: completion)
        task.resume()
        tasks.append(task)
    }

    
}
