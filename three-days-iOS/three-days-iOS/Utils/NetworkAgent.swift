//
//  NetworkAgent.swift
//  three-days-iOS
//
//  Created by 최정인 on 2023/06/18.
//

import Foundation
import Combine

// 네트워크 통신
struct NetworkAgent {
    static func executeRequest<T: Decodable>(_ request:URLRequest, responseType: T.Type) -> AnyPublisher<T, Error> {
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response -> Data in
                guard let httpResponse = response as? HTTPURLResponse,
                      200..<300 ~= httpResponse.statusCode else {
                    print("💥 BAD Server Response")
                    throw URLError(.badServerResponse)
                }
                
                guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                      let dataJSON = json["data"] as? [String: Any],
                      let data = try? JSONSerialization.data(withJSONObject: dataJSON) else {
                    print("💥 BAD Server Response")
                    throw URLError(.badServerResponse)
                }
                print("🌐 Server Response Success")
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .handleEvents(receiveOutput: { response in
                print("✅ Response: ", response)
            }, receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    print("❌ Error: ", error)
                }
            })
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
