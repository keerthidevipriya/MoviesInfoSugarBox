//
//  NetworkManager.swift
//  MoviesInfoSugarBox
//
//  Created by Keerthi Devipriya(kdp) on 21/11/23.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

protocol ResponseModel: Codable {
    // Define any common properties or methods for your response model
}

class NetworkManager {
    typealias CompletionHandler<T: Codable> = (Result<T, Error>) -> Void
    typealias CompletionHandler2 = (Result<URL, Error>) -> Void
    typealias ProgressHandler = (Double) -> Void
    
    private var baseUrl: String
    init(baseUrl: String) {
        self.baseUrl = baseUrl
    }
    
    private func createRequest(url: String, method: HTTPMethod, body: Data?) -> URLRequest {
        let url = URL.init(string: url)!
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.httpBody = body
        return request
    }
    
    func fetchData<T: Codable>(from endPoint: String, method: HTTPMethod, body: Data? = nil, _ completionHandler: @escaping CompletionHandler<T>) {
        let url = baseUrl.appending(endPoint)
        let request = createRequest(url: url, method: method, body: body)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completionHandler(.failure(error))
            }
            if let curlCommand = (response as? HTTPURLResponse)?.url?.absoluteString as? String {
                print("curl command: \(curlCommand)")
            }
            do {
                let decoder = JSONDecoder()
//                let responseString = String(data: data!, encoding: .utf8)
//                print("Response JSON: \(responseString ?? "Invalid JSON")")
                let model = try decoder.decode(T.self, from: data!)
                completionHandler(.success(model))
            } catch {
                completionHandler(.failure(error))
            }
        }
        task.resume()
    }
    
    func downloadVideo(from endPoint: String, _ progressHandler: ProgressHandler? = nil, _ completionHandler: @escaping CompletionHandler2) {
        let urlString = baseUrl.appending(endPoint)
        let url = URL(string: urlString)!
        let urlRequest = URLRequest(url: url)
        let task = URLSession.shared.downloadTask(with: urlRequest) { url, urlResponse, error in
            if let error = error {
                completionHandler(.failure(error))
            }
            if let url = url {
                do {
                    let documentURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                    let destinationURL = documentURL.appending(path: url.lastPathComponent)
                    try FileManager.default.moveItem(at: url, to: destinationURL)
                    completionHandler(.success(destinationURL))
                } catch {
                    completionHandler(.failure(error))
                }
            }
        }
        if let progressHandler = progressHandler {
            let progressObeserver = task.progress.observe(\.fractionCompleted) { prgress, _ in
                progressHandler(prgress.fractionCompleted)
            }
            task.addObserver(progressObeserver, forKeyPath: "fractionCompleted", context: nil)
        }
        task.resume()
       
    }
}
