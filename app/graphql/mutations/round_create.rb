module Mutations
  class RoundCreate < BaseMutation
    description "Creates a new round"

    field :round, Types::RoundType, null: false

    def resolve
      round = Round.create!
      { round: round }
    end
  end
end
