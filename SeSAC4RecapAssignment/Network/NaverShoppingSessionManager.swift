//
//  NaverShoppingSessionManager.swift
//  SeSAC4RecapAssignment
//
//  Created by Minho on 2/7/24.
//

import Foundation

enum NaverShoppingError: Error {
    case failedRequest
    case noData
    case invalidResponse
    case invalidData
}

class NaverShoppingSessionManager {
    
    static let shared = NaverShoppingSessionManager()
    
    // MARK: 모델 변경,
    typealias CompletionHandler = (NaverShopModel?, NaverShoppingError?) -> Void
    
    func request(query: String, start: Int, sortType: ItemSortType, completionHandler: @escaping CompletionHandler) {
        
        let scheme = "https"
        let host = "openapi.naver.com"
        let path = "/v1/search/shop.json"
        
        var component = URLComponents()
        component.scheme = scheme
        component.host = host
        component.path = path
        component.queryItems = [
            URLQueryItem(name: "query", value: query),
            URLQueryItem(name: "start", value: "\(start)"),
            URLQueryItem(name: "display", value: "\(30)"),
            URLQueryItem(name: "sortType", value: sortType.query)
        ]
        
        // URLRequest vs URL
        var url = URLRequest(url: component.url!)
        url.httpMethod = "GET"
        url.addValue(APIKey.id, forHTTPHeaderField: "X-Naver-Client-Id")
        url.addValue(APIKey.secret, forHTTPHeaderField: "X-Naver-Client-Secret")
        
        print("url: \(url)")
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            DispatchQueue.main.async {
                guard error == nil else {
                    print("네트워크 통신 실패")
                    completionHandler(nil, .failedRequest)
                    return
                }
                
                // 네트워크 통신 성공
                guard let data = data else {
                    print("통신은 성공했으나 데이터가 없음")
                    completionHandler(nil, .noData)
                    return
                }
                
                // Optional 103bytes 라고 떴던 내용이 제대로 표시되게 됨.
                // print(String(data: data, encoding: .utf8))
                
                guard let response = response as? HTTPURLResponse else {
                    print("통신은 성공했지만, 응답값(예. 상태코드)이 오지 않음")
                    completionHandler(nil, .invalidResponse)
                    return
                }
                
                guard response.statusCode == 200 else {
                    print("통신은 성공했으나 값이 오지 않은 상태")
                    completionHandler(nil, .failedRequest)
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(NaverShopModel.self, from: data)
                    dump(result.items)
                    print("통신 성공")
                    completionHandler(result, nil)
                } catch {
                    print(error)
                    completionHandler(nil, .invalidData)
                }
            }
            
        }.resume()
    }
    
}
