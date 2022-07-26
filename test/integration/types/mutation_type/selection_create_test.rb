require "test_helper"

class Types::MutationType::SelectionCreateTest < ActionDispatch::IntegrationTest
  setup do
    @query = <<~GRAPHQL
      mutation SelectionCreate($roundId: ID!) {
        selectionCreate(input: {
          selectionInput: {
            roundId: $roundId
          }
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

  test "selection_create" do
    round = rounds(:empty)
    variables = { roundId: round.id }

    assert_difference -> { Selection.count } do
      post graphql_path, params: { query: @query, variables: variables }

      selection = Selection.last

      assert_equal(
        {
          "data" => {
            "selectionCreate" => {
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
    end
  end

  test "selection_create with errors" do
    round = rounds(:full)
    variables = { roundId: round.id }

    assert_no_difference -> { Selection.count } do
      post graphql_path, params: { query: @query, variables: variables }

      assert_equal(
        {
          "data" => {
            "selectionCreate" => nil,
          },
          "errors" => [
            {
              "message" => "Selection invalid",
              "locations" => [{ "line" => 2, "column" => 3 }],
              "path" => ["selectionCreate"],
              "extensions" => { "user" => ["must exist"] },
            },
          ],
        },
        @response.parsed_body
      )
    end
  end
end
