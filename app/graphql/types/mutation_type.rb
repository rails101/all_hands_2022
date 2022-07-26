module Types
  class MutationType < Types::BaseObject
    field :round_create, mutation: Mutations::RoundCreate
    field :user_create, mutation: Mutations::UserCreate
  end
end
