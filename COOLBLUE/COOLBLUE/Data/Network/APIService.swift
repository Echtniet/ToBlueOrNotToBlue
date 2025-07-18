//
//  APIService.swift
//  COOLBLUE
//
//  Created by Clinton on 15/07/2025.
//

import Foundation

protocol APIServiceProtocol {
    func fetchStores() async throws -> [StoreDTO]
}

class APIService: APIServiceProtocol {
    private var apolloNetwork: ApolloNetwork

    public init(apolloNetwork: ApolloNetwork) {
        self.apolloNetwork = apolloNetwork
    }

    func fetchStores() async throws -> [StoreDTO] {
        try await withCheckedThrowingContinuation { continuation in
            apolloNetwork.apollo.fetch(query: CoolBlue.GetStoresQuery()) { result in
                switch result {
                case .success(let graphQLResult):
                    if let gqlStores = graphQLResult.data?.stores {
                        let stores: [StoreDTO] = gqlStores.map { StoreDTO(gqlStore: $0) }
                        continuation.resume(returning: stores)
                    } else if let errors = graphQLResult.errors {
                        let errorDescription = errors.map { $0.localizedDescription }.joined(separator: "\n")
                        continuation.resume(throwing: NSError(domain: "GraphQL", code: 1, userInfo: [NSLocalizedDescriptionKey: errorDescription]))
                    } else {
                        continuation.resume(throwing: NSError(domain: "GraphQL", code: 2, userInfo: [NSLocalizedDescriptionKey: "Unknown error occurred"]))
                    }
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}

class UITestingMockAPIService: APIServiceProtocol {
    func fetchStores() async throws -> [StoreDTO] {
        return [
            .init(
                id: "176",
                name: "The Hague",
                address: .init(
                    street: "Anna van Buerenplein",
                    houseNumber: "7",
                    houseNumberAddition: nil,
                    postalCode: "2595 DA",
                    country: "NL",
                    latitude: 52.08300000,
                    longitude: 4.32533300
                )
            )
        ]
    }
}

