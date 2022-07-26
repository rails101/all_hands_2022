module Types
  class MutationType < Types::BaseObject
    field :round_create, mutation: Mutations::RoundCreate
    field :selection_create, mutation: Mutations::SelectionCreate
    field :selection_delete, mutation: Mutations::SelectionDelete
    field :user_create, mutation: Mutations::UserCreate
  end
end
