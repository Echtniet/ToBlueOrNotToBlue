//
//  ApolloNetowork.swift
//  COOLBLUE
//
//  Created by Clinton on 15/07/2025.
//

import Apollo
import Foundation

final class ApolloNetwork {

    private let store = ApolloStore()

    private let sessionConfiguration: URLSessionConfiguration = {
        let config = URLSessionConfiguration.default
        config.httpAdditionalHeaders = [
            "Accept-Language": "en-nl",
            "Content-Type": "application/json",
            "apollo-require-preflight": "true"
        ]
        return config
    }()

    private let client: URLSessionClient
    private let provider: NetworkInterceptorProvider
    private let transport: RequestChainNetworkTransport

    let apollo: ApolloClient

    public init() {
        self.client = URLSessionClient(sessionConfiguration: sessionConfiguration)
        self.provider = NetworkInterceptorProvider(store: store, client: client)
        self.transport = RequestChainNetworkTransport(
            interceptorProvider: provider,
            endpointURL: URL(string: "https://mobile-api.coolblue-production.eu/graphql")!
        )
        self.apollo = ApolloClient(networkTransport: transport, store: store)
    }
}

class NetworkInterceptorProvider: InterceptorProvider {
    let store: ApolloStore
    let client: URLSessionClient

    init(store: ApolloStore, client: URLSessionClient) {
        self.store = store
        self.client = client
    }

    func interceptors<Operation>(
        for operation: Operation
    ) -> [ApolloInterceptor] where Operation: GraphQLOperation {
        [
            MaxRetryInterceptor(),
            CacheReadInterceptor(store: self.store),
            NetworkFetchInterceptor(client: self.client),
            ResponseCodeInterceptor(),
            CustomHeadersInterceptor(),
            JSONResponseParsingInterceptor(),
            CacheWriteInterceptor(store: self.store)
        ]
    }
}

class CustomHeadersInterceptor: ApolloInterceptor {
    var id: String = "CustomHeadersInterceptor"

    func interceptAsync<Operation>(
        chain: RequestChain,
        request: HTTPRequest<Operation>,
        response: HTTPResponse<Operation>?,
        completion: @escaping (Result<GraphQLResult<Operation.Data>, Error>) -> Void
    ) {
        chain.proceedAsync(
            request: request,
            response: response,
            interceptor: self,
            completion: completion
        )
    }
}
