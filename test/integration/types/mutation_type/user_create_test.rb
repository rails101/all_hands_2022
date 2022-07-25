require "test_helper"

class Types::MutationType::UserCreateTest < ActionDispatch::IntegrationTest
  setup do
    @query = <<~GRAPHQL
      mutation UserCreate($name: String!, $email: String!) {
        userCreate(input: {
          userInput: {
            name: $name
            email: $email
          }
        }) {
          user {
            id
            name
            email
            createdAt
            updatedAt
          }
        }
      }
    GRAPHQL
  end

  test "user_create" do
    variables = {
      name: "Test User",
      email: "test@hipcamp.com",
    }

    post graphql_path, params: { query: @query, variables: variables }

    user = User.last

    assert_equal(
      {
        "data" => {
          "userCreate" => {
            "user" => {
              "id" => user.id.to_s,
              "name" => user.name,
              "email" => user.email,
              "createdAt" => user.created_at.iso8601,
              "updatedAt" => user.updated_at.iso8601,
            },
          },
        },
      },
      @response.parsed_body
    )

    assert_equal(user.name, "Test User")
    assert_equal(user.email, "test@hipcamp.com")
  end

  test "user_create with errors" do
    variables = {
      name: "Test User",
      email: users(:daniel).email,
    }

    post graphql_path, params: { query: @query, variables: variables }

    assert_equal(
      {
        "data" => {
          "userCreate" => nil,
        },
        "errors" => [
          {
            "message" => "User invalid",
            "locations" => [{ "line" => 2, "column" => 3 }],
            "path" => ["userCreate"],
            "extensions" => { "email" => ["has already been taken"] },
          },
        ],
      },
      @response.parsed_body
    )
  end
end
