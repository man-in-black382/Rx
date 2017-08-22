//
//  GithubEndpoint.swift
//  Rx
//
//  Created by Pavlo Muratov on 22.08.17.
//  Copyright © 2017 MPO. All rights reserved.
//

import Foundation
import Moya

private extension String {
    var URLEscapedString: String {
        return self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlHostAllowed)!
    }
}

enum GitHub {
    case userProfile(username: String)
    case repos(username: String)
    case repo(fullName: String)
    case issues(repositoryFullName: String)
}

extension GitHub: TargetType {
    var baseURL: URL { return URL(string: "https://api.github.com")! }
    var method: Moya.Method { return .get }
    var parameters: [String : Any]? { return nil }
    var task: Task { return .request }
    var parameterEncoding: ParameterEncoding { return JSONEncoding.default }
    
    var path: String {
        switch self {
        case .repos(let username): return "/users/\(username.URLEscapedString)/repos"
        case .userProfile(let username): return "/users/\(username.URLEscapedString)"
        case .repo(let fullName): return "/repos/\(fullName.URLEscapedString)"
        case .issues(let repoName): return "/repos/\(repoName.URLEscapedString)/issues"
        }
    }
    
    var sampleData: Data {
        switch self {
        case .repos(_):
            return "{{\"id\": \"1\", \"language\": \"Swift\", \"url\": \"https://api.github.com/repos/mjacko/Router\", \"name\": \"Router\"}}}".data(using: .utf8)!
        case .userProfile(let name):
            return "{\"login\": \"\(name)\", \"id\": 100}".data(using: .utf8)!
        case .repo(_):
            return "{\"id\": \"1\", \"language\": \"Swift\", \"url\": \"https://api.github.com/repos/mjacko/Router\", \"name\": \"Router\"}".data(using: .utf8)!
        case .issues(_):
            return "{\"id\": 132942471, \"number\": 405, \"title\": \"Updates example with fix to String extension by changing to Optional\", \"body\": \"Fix it pls.\"}".data(using: .utf8)!
        }
    }
    
}
