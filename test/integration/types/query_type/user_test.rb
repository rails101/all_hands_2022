require "test_helper"

class Types::QueryType::UserTest < ActionDispatch::IntegrationTest
  setup do
    @query = <<~GRAPHQL
      query User($id: ID!) {
        user(id: $id) {
          id
          name
          email
          createdAt
          updatedAt
        }
      }
    GRAPHQL
  end

  test "user" do
    user = users(:daniel)

    post graphql_path, params: { query: @query, variables: { id: user.id } }

    assert_equal(
      {
        "data" => {
          "user" => {
            "id" => user.id.to_s,
            "name" => user.name,
            "email" => user.email,
            "createdAt" => user.created_at.iso8601,
            "updatedAt" => user.updated_at.iso8601,
          },
        },
      },
      @response.parsed_body
    )
  end

  test "user not found" do
    post graphql_path, params: { query: @query, variables: { id: "0" } }

    assert_equal(
      {
        "data" => nil,
        "errors" => [
          {
            "message" => "User not found",
            "locations" => [{ "line" => 2, "column" => 3 }],
            "path" => ["user"],
          },
        ],
      },
      @response.parsed_body
    )
  end
end
