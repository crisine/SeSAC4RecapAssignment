//
//  NaverShoppingAPI.swift
//  SeSAC4RecapAssignment
//
//  Created by Minho on 2/7/24.
//

import Alamofire

enum NaverShoppingAPI {
    
    // URL
    case trending
    case search(query: String) //
    case photo(id: Int) // 서버에서 보내주는 id는 Int형태
    
    //
    var baseURL: String {
        return "https://openapi.naver.com/v1/search/shop.json"
    }
    
    var endpoint: URL {
        switch self {
        case .trending:
            return URL(string: baseURL + "trending/movie/week")!
        case .search:
            return URL(string: baseURL + "search/movie")!
        case .photo:
            return URL(string: baseURL + "movie/{id}/images")!
        }
    }
    
    var header: HTTPHeaders {
        return ["Authorization": APIKey.tmdb]
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var parameter: Parameters {
        switch self {
        case .trending:
            ["": ""]
        case .search(let query):
            ["language": "ko-KR", "query": query]
        case .photo:
            ["": ""]
        }
    }
}
