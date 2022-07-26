require "test_helper"

class Types::MutationType::RoundCreateTest < ActionDispatch::IntegrationTest
  setup do
    @query = <<~GRAPHQL
      mutation RoundCreate {
        roundCreate(input: {}) {
          round {
            id
            createdAt
            updatedAt
            selections {
              id
            }
          }
        }
      }
    GRAPHQL
  end

  test "round_create" do
    assert_difference -> { Round.count } do
      post graphql_path, params: { query: @query }

      round = Round.last

      assert_equal(
        {
          "data" => {
            "roundCreate" => {
              "round" => {
                "id" => round.id.to_s,
                "createdAt" => round.created_at.iso8601,
                "updatedAt" => round.updated_at.iso8601,
                "selections" => [],
              },
            },
          },
        },
        @response.parsed_body
      )
    end
  end
end
