module Mutations
  class UserCreate < BaseMutation
    description "Creates a new user"

    field :user, Types::UserType, null: false

    argument :user_input, Types::UserInputType, required: true

    def resolve(user_input:)
      user = User.create!(**user_input)
      { user: user }
    end
  end
end
