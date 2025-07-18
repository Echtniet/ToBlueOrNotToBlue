//
//  LocationService.swift
//  COOLBLUE
//
//  Created by Clinton on 15/07/2025.
//

import CoreLocation
import Combine

protocol LocationServiceProtocol {
    func requestCurrentLocation() -> AnyPublisher<CLLocation, Never>
}

final class LocationService: NSObject, ObservableObject, LocationServiceProtocol {
    private let locationManager = CLLocationManager()
    private let locationSubject = PassthroughSubject<CLLocation, Never>()

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
    }

    func requestCurrentLocation() -> AnyPublisher<CLLocation, Never> {
        locationManager.requestLocation()
        return locationSubject.eraseToAnyPublisher()
    }
}

extension LocationService: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationSubject.send(location)
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            print("❌ Location error: \(error.localizedDescription)")
        }
}
