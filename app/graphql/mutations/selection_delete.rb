module Mutations
  class SelectionDelete < BaseMutation
    description "Deletes a selection by ID"

    field :selection, Types::SelectionType, null: false

    argument :id, ID, required: true

    def resolve(id:)
      selection = Selection.find(id)
      selection.destroy!
      { selection: selection }
    end
  end
end
