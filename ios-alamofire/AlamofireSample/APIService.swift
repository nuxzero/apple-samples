//
//  APIService.swift
//  AlamofireSample
//
//  Created by Natthawut Haematulin on 15/7/2561 BE.
//  Copyright © 2561 Natthawut Haematulin. All rights reserved.
//

import Foundation
import Alamofire

public struct APIService {
    
    var baseURL: String
    
    func buildURL(endpoint: String) -> String {
        return "\(baseURL)/\(endpoint)"
    }
    
    /**
     * GET request
     */
    func get<T: Codable>(endpoint: String, type: T.Type, success: @escaping (_ response: T?)-> Void, failure: @escaping (_ error: Error) -> Void) {
        Alamofire.request(buildURL(endpoint: endpoint)).responseJSON { res in
            switch res.result {
            case .success:                
                let decoder = JSONDecoder()
                do {
                    let result: T = try decoder.decode(type, from: res.data!)
                    success(result)
                } catch let err {
                    failure(err)
                }
            case .failure(let error):
                failure(error)
            }
        }
    }
    
    /**
     * POST request
     */
    func post<T1: Codable, T2: Codable>(endpoint: String, type: T1.Type, body: T2? = nil, success: @escaping (_ response: T1?)-> Void, failure: @escaping (_ error: Error) -> Void) {
        var parameters: [String: Any]? = nil
        
        do {
            parameters = try toDictionary(from: body)
        } catch let error {
            failure(error)
            return
        }
        
        print("Parameters: \(parameters)")
        
        Alamofire.request(buildURL(endpoint: endpoint), method: .post, parameters: parameters, encoding: URLEncoding.default).responseJSON { res in
            switch res.result {
            case .success:
                let decoder = JSONDecoder()
                do {
                    print(String(decoding: res.data!, as: UTF8.self))
                    
                    let result: T1 = try decoder.decode(type, from: res.data!)
                    success(result)
                } catch let err {
                    failure(err)
                }
            case .failure(let error):
                failure(error)
            }
        }
    }
    
    /**
     * Request operation.
     *
     * @param url: String
     * @param method: HTTPMethod = .get
     * @param parameters: [String: Any]? = nil
     * @param headers: [String: Any]? = nil
     * @param type: T.Type
     * @param success: @escaping (_ response: T?)-> Void
     * @param failure: @escaping (_ error: Error) -> Void
     */
    func sendRequest<T: Codable>(url: String,
                                 method: HTTPMethod = .get,
                                 parameters: [String: Any]? = nil,
                                 headers: [String: Any]? = nil,
                                 type: T.Type,
                                 success: @escaping (_ response: T?)-> Void,
                                 failure: @escaping (_ error: Error) -> Void) {

        Alamofire.request(url, method: method, parameters: parameters, encoding: URLEncoding.default).responseJSON { res in
            switch res.result {
            case .success:
                let decoder = JSONDecoder()
                do {
                    print(String(decoding: res.data!, as: UTF8.self))
                    
                    let result: T = try decoder.decode(type, from: res.data!)
                    success(result)
                } catch let err {
                    failure(err)
                }
            case .failure(let error):
                failure(error)
            }
        }
    }
    
    /**
     * Deserialize data from response to a particular object.
     *
     * @param data Data JSON response
     * @param type Type of Codable object
     *
     * @return Codable object
     */
    func decodeJSON<T:Codable>(data: Data, type: T.Type) throws -> T {
        let decoder = JSONDecoder()
        do {
            return try decoder.decode(type, from: data)
        } catch let err {
            throw err
        }
    }
    
    /**
     * Convert a particular Codable object to Dictionary.
     *
     * @param object Codable object
     *
     * @return [String: Any]
     */
    func toDictionary<T: Codable>(from object: T) throws -> [String: Any] {
        let data = try JSONEncoder().encode(object)
        guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            throw NSError(domain: "Object can not convert to dictionary.", code: 400)
        }
        return dictionary
    }
}
