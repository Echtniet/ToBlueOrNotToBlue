//
//  DIContainer.swift
//  COOLBLUE
//
//  Created by Clinton on 15/07/2025.
//

import Swinject

@MainActor
class DIContainer {
    static let shared = DIContainer()
    let container: Container

    private init() {
        container = Container()

        registerDependencies()
        registerServices()
        registerDataCaches()
        registerRepositories()
        registerUseCases()
        registerViewModels()
        registerCoordinator()
    }

    private func registerDependencies() {
        container.register(ApolloNetwork.self) { _ in
            ApolloNetwork()
        }
        .inObjectScope(.container)
    }

    private func registerServices() {
        if CommandLine.arguments.contains("--uitesting") {
            container.register(APIServiceProtocol.self) { resolver in
                UITestingMockAPIService()
            }
            .inObjectScope(.weak)
        } else {
            container.register(APIServiceProtocol.self) { resolver in
                APIService(apolloNetwork: resolver.resolve(ApolloNetwork.self)!)
            }
            .inObjectScope(.weak)
        }
        container.register(LocationServiceProtocol.self) { resolver in
            LocationService()
        }
        .inObjectScope(.weak)
    }

    private func registerDataCaches() {
        container.register(DataCache<[Store]>.self) { _ in
            DataCache<[Store]>()
        }
        .inObjectScope(.container)
    }

    private func registerRepositories() {
        container.register(StoresRepositoryProtocol.self) { resolver in
            StoresRepository(
                apiService: resolver.resolve(APIServiceProtocol.self)!,
                dataCache: resolver.resolve(DataCache<[Store]>.self)!
            )
        }
        .inObjectScope(.weak)
    }

    private func registerUseCases() {
        container.register(StoresUseCaseProtocol.self) { resolver in
            StoresUseCase(
                storesRepository: resolver.resolve(StoresRepositoryProtocol.self )!
            )
        }
        .inObjectScope(.weak)
        container.register(LocationSortUseCaseProtocol.self) { _ in
            LocationSortUseCase()
        }
        .inObjectScope(.weak)
        container.register(OpeningHoursSortUseCaseProtocol.self) { _ in
            OpeningHoursSortUseCase()
        }
        .inObjectScope(.weak)
    }

    private func registerViewModels() {
        container.register(StoresPageViewModel.self) { resolver in
            StoresPageViewModel(
                locationService: resolver.resolve(LocationServiceProtocol.self)!,
                storesUseCase: resolver.resolve(StoresUseCaseProtocol.self)!,
                locationSortUseCase: resolver.resolve(LocationSortUseCaseProtocol.self)!,
                openingHoursSortUseCase: resolver.resolve(OpeningHoursSortUseCaseProtocol.self)!
            )
        }
        container.register(StoresPageDetailViewModel.self) { resolver in
            StoresPageDetailViewModel(
                storesUseCase: resolver.resolve(StoresUseCaseProtocol.self)!
            )
        }
    }

    private func registerCoordinator() {
        container.register(StoresPageCoordinator.self) { _ in
            StoresPageCoordinator()
        }
        .inObjectScope(.container)
        container.register(AppCoordinator.self) { resolver in
            AppCoordinator(
                storesPageCoordinator: resolver.resolve(StoresPageCoordinator.self)!)
        }
        .inObjectScope(.container)
    }

    func resolve<T>(_ type: T.Type) -> T {
        return container.resolve(type.self)!
    }
}
