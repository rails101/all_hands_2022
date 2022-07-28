require "test_helper"

class Types::QueryType::UsersTest < ActionDispatch::IntegrationTest
  test "users" do
    query = <<~GRAPHQL
      {
        users {
          id
          name
          email
          createdAt
          updatedAt
          archived
        }
      }
    GRAPHQL

    post graphql_path, params: { query: query }

    users_in_email_order = [
      users(:adrian),
      users(:casper),
      users(:chantel),
      users(:daniel),
      users(:fatso),
      users(:sarah),
      users(:stinkie),
      users(:stretch),
    ]

    assert_equal(
      {
        "data" => {
          "users" => users_in_email_order.map { |user|
            {
              "id" => user.id.to_s,
              "name" => user.name,
              "email" => user.email,
              "createdAt" => user.created_at.iso8601,
              "updatedAt" => user.updated_at.iso8601,
              "archived" => user.archived,
            }
          },
        },
      },
      @response.parsed_body
    )
  end
end
