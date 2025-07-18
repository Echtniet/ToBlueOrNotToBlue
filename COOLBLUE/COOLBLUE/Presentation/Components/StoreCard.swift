//
//  StoreCard.swift
//  COOLBLUE
//
//  Created by Clinton on 16/07/2025.
//

import SwiftUI

struct StoreCard: View {

    let store: Store
    let onSelect: () -> Void

    var body: some View {
        Button {
            onSelect()
        } label: {
            VStack(alignment: .leading) {
                Text(store.name)
                if let address = store.address {
                    Text(address.formatted)
                }
                if let openingTime = store.todayOpeningHours?.openTime, let closingTime = store.todayOpeningHours?.closeTime {
                    Text("\(openingTime.formattedHourMinute)-\(closingTime.formattedHourMinute)")
                }
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.blue.gradient.opacity(0.2))
                    .shadow(radius: 3, x: 1, y: 2)
            )
        }
        .buttonStyle(PlainButtonStyle())
        .accessibilityIdentifier("StoreCard_\(store.name)")
    }
}
