// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

extension CoolBlue {
  class GetStoresQuery: GraphQLQuery {
    static let operationName: String = "GetStores"
    static let operationDocument: ApolloAPI.OperationDocument = .init(
      definition: .init(
        #"query GetStores { stores { __typename id name address { __typename street houseNumber houseNumberAddition postalCode country latitude longitude } todayOpeningHours { __typename scheduleDate openTime closeTime } } }"#
      ))

    public init() {}

    struct Data: CoolBlue.SelectionSet {
      let __data: DataDict
      init(_dataDict: DataDict) { __data = _dataDict }

      static var __parentType: any ApolloAPI.ParentType { CoolBlue.Objects.Query }
      static var __selections: [ApolloAPI.Selection] { [
        .field("stores", [Store]?.self),
      ] }

      var stores: [Store]? { __data["stores"] }

      /// Store
      ///
      /// Parent Type: `Store`
      struct Store: CoolBlue.SelectionSet {
        let __data: DataDict
        init(_dataDict: DataDict) { __data = _dataDict }

        static var __parentType: any ApolloAPI.ParentType { CoolBlue.Objects.Store }
        static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("id", CoolBlue.ID.self),
          .field("name", String.self),
          .field("address", Address?.self),
          .field("todayOpeningHours", TodayOpeningHours?.self),
        ] }

        /// Unique identifier of the physical Coolblue store. This Id is the same as the stockLocationId from Oracle. (Source: Stores CMS)
        var id: CoolBlue.ID { __data["id"] }
        /// Name of the localized Coolblue store. (Source: Oracle)
        var name: String { __data["name"] }
        /// Returns the address in a given store. (Source: Oracle)
        var address: Address? { __data["address"] }
        /// Returns the current opening and closing times in a given store. (Source: Oracle)
        var todayOpeningHours: TodayOpeningHours? { __data["todayOpeningHours"] }

        /// Store.Address
        ///
        /// Parent Type: `StoreAddress`
        struct Address: CoolBlue.SelectionSet {
          let __data: DataDict
          init(_dataDict: DataDict) { __data = _dataDict }

          static var __parentType: any ApolloAPI.ParentType { CoolBlue.Objects.StoreAddress }
          static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("street", String.self),
            .field("houseNumber", String.self),
            .field("houseNumberAddition", String?.self),
            .field("postalCode", String.self),
            .field("country", String.self),
            .field("latitude", Double.self),
            .field("longitude", Double.self),
          ] }

          /// Store street name
          var street: String { __data["street"] }
          /// Store house number
          var houseNumber: String { __data["houseNumber"] }
          /// Store house number additional information
          var houseNumberAddition: String? { __data["houseNumberAddition"] }
          /// Store postal code
          var postalCode: String { __data["postalCode"] }
          /// Store Country
          var country: String { __data["country"] }
          /// Store Latitude
          var latitude: Double { __data["latitude"] }
          /// Store Longitude
          var longitude: Double { __data["longitude"] }
        }

        /// Store.TodayOpeningHours
        ///
        /// Parent Type: `StoreTimeFrame`
        struct TodayOpeningHours: CoolBlue.SelectionSet {
          let __data: DataDict
          init(_dataDict: DataDict) { __data = _dataDict }

          static var __parentType: any ApolloAPI.ParentType { CoolBlue.Objects.StoreTimeFrame }
          static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("scheduleDate", CoolBlue.Date.self),
            .field("openTime", CoolBlue.Time?.self),
            .field("closeTime", CoolBlue.Time?.self),
          ] }

          /// Store opening date. Store needs to be active 7 days before the scheduleDate
          var scheduleDate: CoolBlue.Date { __data["scheduleDate"] }
          /// Store opening time. When both open and close times on the same date are 00:00, it means the location is closed all day on that date.
          var openTime: CoolBlue.Time? { __data["openTime"] }
          /// Store closing time. When both open and close times on the same date are 00:00, it means the location is closed all day on that date.
          var closeTime: CoolBlue.Time? { __data["closeTime"] }
        }
      }
    }
  }

}