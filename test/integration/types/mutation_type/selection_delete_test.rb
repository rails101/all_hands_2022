require "test_helper"

class Types::MutationType::SelectionDeleteTest < ActionDispatch::IntegrationTest
  setup do
    @query = <<~GRAPHQL
      mutation SelectionDelete($id: ID!) {
        selectionDelete(input: {
          id: $id
        }) {
          selection {
            id
            createdAt
            updatedAt
            user {
              id
              name
              email
              createdAt
              updatedAt
            }
          }
        }
      }
    GRAPHQL
  end

  test "selection_delete" do
    selection = selections(:full_daniel)
    variables = { id: selection.id }

    assert_difference -> { Selection.count }, -1 do
      post graphql_path, params: { query: @query, variables: variables }

      assert_equal(
        {
          "data" => {
            "selectionDelete" => {
              "selection" => {
                "id" => selection.id.to_s,
                "createdAt" => selection.created_at.iso8601,
                "updatedAt" => selection.updated_at.iso8601,
                "user" => {
                  "id" => selection.user.id.to_s,
                  "name" => selection.user.name,
                  "email" => selection.user.email,
                  "createdAt" => selection.user.created_at.iso8601,
                  "updatedAt" => selection.user.updated_at.iso8601,
                },
              },
            },
          },
        },
        @response.parsed_body
      )

      assert_nil Selection.find_by(id: selection.id)
    end
  end
end
