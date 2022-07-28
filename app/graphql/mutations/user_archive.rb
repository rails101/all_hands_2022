module Mutations
  class UserArchive < BaseMutation
    description "Archives or unarchives a user by ID"

    field :user, Types::UserType, null: false

    argument :id, ID, required: true

    def resolve(id:)
      user = User.find(id)
      user.toggle!(:archived)
      { user: user }
    end
  end
end
