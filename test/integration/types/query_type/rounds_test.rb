require "test_helper"

class Types::QueryType::RoundsTest < ActionDispatch::IntegrationTest
  test "rounds" do
    query = <<~GRAPHQL
      {
        rounds {
          id
          createdAt
          updatedAt
          selections {
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

    post graphql_path, params: { query: query }

    rounds_in_id_order = {
      rounds(:full) => [
        selections(:full_adrian),
        selections(:full_daniel),
        selections(:full_chantel),
        selections(:full_sarah),
      ],
      rounds(:empty) => [],
    }

    assert_equal(
      {
        "data" => {
          "rounds" => rounds_in_id_order.map { |round, selections|
            {
              "id" => round.id.to_s,
              "createdAt" => round.created_at.iso8601,
              "updatedAt" => round.updated_at.iso8601,
              "selections" => selections.map { |selection|
                {
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
                }
              },
            }
          },
        },
      },
      @response.parsed_body
    )
  end
end
