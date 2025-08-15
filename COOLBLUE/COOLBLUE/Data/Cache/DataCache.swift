//
//  DataCache.swift
//  COOLBLUE
//
//  Created by Clinton on 15/07/2025.
//

import Foundation

actor DataCache<T> {
    private var cache: T?

    func get() -> T? { cache }
    func set(_ value: T) { cache = value }
    func clear() { cache = nil }
}
