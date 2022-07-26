module Types
  class SelectionInputType < Types::BaseInputObject
    argument :round_id, ID, required: true
  end
end
