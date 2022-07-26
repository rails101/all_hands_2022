module Mutations
  class SelectionCreate < BaseMutation
    description "Creates a new selection"

    field :selection, Types::SelectionType, null: false

    argument :selection_input, Types::SelectionInputType, required: true

    def resolve(selection_input:)
      selection = Selection.create!(**selection_input)
      { selection: selection }
    end
  end
end
