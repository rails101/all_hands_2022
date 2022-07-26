module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    field :rounds, [RoundType], null: false,
      description: "List all rounds in creation order"

    field :users, [Types::UserType], null: false,
      description: "List all users in email order"

    field :user, Types::UserType, "Find a user by ID", null: false do
      argument :id, ID
    end

    def rounds
      Round.all.order(:id)
    end

    def users
      User.all.order(:email)
    end

    def user(id:)
      User.find(id)
    end
  end
end
