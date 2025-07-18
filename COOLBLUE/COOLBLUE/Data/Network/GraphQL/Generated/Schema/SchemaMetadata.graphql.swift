// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

protocol CoolBlue_SelectionSet: ApolloAPI.SelectionSet & ApolloAPI.RootSelectionSet
where Schema == CoolBlue.SchemaMetadata {}

protocol CoolBlue_InlineFragment: ApolloAPI.SelectionSet & ApolloAPI.InlineFragment
where Schema == CoolBlue.SchemaMetadata {}

protocol CoolBlue_MutableSelectionSet: ApolloAPI.MutableRootSelectionSet
where Schema == CoolBlue.SchemaMetadata {}

protocol CoolBlue_MutableInlineFragment: ApolloAPI.MutableSelectionSet & ApolloAPI.InlineFragment
where Schema == CoolBlue.SchemaMetadata {}

extension CoolBlue {
  typealias SelectionSet = CoolBlue_SelectionSet

  typealias InlineFragment = CoolBlue_InlineFragment

  typealias MutableSelectionSet = CoolBlue_MutableSelectionSet

  typealias MutableInlineFragment = CoolBlue_MutableInlineFragment

  enum SchemaMetadata: ApolloAPI.SchemaMetadata {
    static let configuration: any ApolloAPI.SchemaConfiguration.Type = SchemaConfiguration.self

    static func objectType(forTypename typename: String) -> ApolloAPI.Object? {
      switch typename {
      case "Query": return CoolBlue.Objects.Query
      case "Store": return CoolBlue.Objects.Store
      case "StoreAddress": return CoolBlue.Objects.StoreAddress
      case "StoreTimeFrame": return CoolBlue.Objects.StoreTimeFrame
      default: return nil
      }
    }
  }

  enum Objects {}
  enum Interfaces {}
  enum Unions {}

}