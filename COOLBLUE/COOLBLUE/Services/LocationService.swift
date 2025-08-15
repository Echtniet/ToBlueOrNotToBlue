//
//  LocationService.swift
//  COOLBLUE
//
//  Created by Clinton on 15/07/2025.
//

import CoreLocation
import Combine
import Foundation

protocol LocationServiceProtocol {
    func requestCurrentLocation() -> AnyPublisher<CLLocation, Error>
    func requestCurrentLocationAsync() async throws -> CLLocation
}

enum LocationError: Error {
    case failedToGetLocation
}

actor LocationService: LocationServiceProtocol {
    private let locationManager: CLLocationManager
    private let locationManagerDelegate = LocationManagerDelegate()

    private var getLocationTask: Task<Void, Never>?

    init() {
        self.locationManager = CLLocationManager()
        Task { @MainActor in
            self.locationManager.delegate = await locationManagerDelegate
            self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
            await self.locationManager.requestWhenInUseAuthorization()
        }
    }

    nonisolated func requestCurrentLocation() -> AnyPublisher<CLLocation, Error> {
        Deferred {
            Future { promise in
                Task { @MainActor in
                    await self.locationManagerDelegate.requestLocation(with: self.locationManager) { result in
                        switch result {
                        case .success(let location):
                            promise(.success(location))
                        case .failure(let error):
                            promise(.failure(error))
                            break
                        }
                    }
                }
            }
        }
        .eraseToAnyPublisher()
    }

    func requestCurrentLocationAsync() async throws -> CLLocation {
        try await withCheckedThrowingContinuation { continuation in

            getLocationTask?.cancel()
            getLocationTask = Task { @MainActor in

                guard !Task.isCancelled else {
                    continuation.resume(throwing: CancellationError())
                    return
                }

                locationManagerDelegate.requestLocation(with: locationManager) { result in

                    if Task.isCancelled {
                        continuation.resume(throwing: CancellationError())
                        return
                    }

                    switch result {
                    case .success(let location):
                        continuation.resume(returning: location)
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    }
                }
            }
        }
    }
}

private final class LocationManagerDelegate: NSObject, CLLocationManagerDelegate {

    private var completion: ((Result<CLLocation, Error>) -> Void)?

    func requestLocation(with manager: CLLocationManager, completion: @escaping (Result<CLLocation, Error>) -> Void) {
        self.completion = completion
        manager.requestLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            completion?(.success(location))
        } else {
            completion?(.failure(LocationError.failedToGetLocation))
        }
        completion = nil
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        completion?(.failure(LocationError.failedToGetLocation))
        completion = nil
    }
}
