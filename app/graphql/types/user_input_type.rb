module Types
  class UserInputType < Types::BaseInputObject
    argument :name, String, required: true
    argument :email, String, required: true
  end
end
