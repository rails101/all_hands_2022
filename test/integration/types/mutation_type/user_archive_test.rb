require "test_helper"

class Types::MutationType::UserArchiveTest < ActionDispatch::IntegrationTest
  setup do
    @query = <<~GRAPHQL
      mutation UserArchive($id: ID!) {
        userArchive(input: { id: $id }) {
          user {
            id
            name
            email
            createdAt
            updatedAt
            archived
          }
        }
      }
    GRAPHQL
  end

  test "user_archive" do
    user = users(:daniel)
    variables = { id: user.id }

    assert_changes -> { user.archived }, from: false, to: true do
      post graphql_path, params: { query: @query, variables: variables }

      user.reload

      assert_equal(
        {
          "data" => {
            "userArchive" => {
              "user" => {
                "id" => user.id.to_s,
                "name" => user.name,
                "email" => user.email,
                "createdAt" => user.created_at.iso8601,
                "updatedAt" => user.updated_at.iso8601,
                "archived" => user.archived,
              },
            },
          },
        },
        @response.parsed_body
      )
    end
  end

  test "user_archive when archived" do
    user = users(:casper)
    variables = { id: user.id }

    assert_changes -> { user.archived }, from: true, to: false do
      post graphql_path, params: { query: @query, variables: variables }

      user.reload

      assert_equal(
        {
          "data" => {
            "userArchive" => {
              "user" => {
                "id" => user.id.to_s,
                "name" => user.name,
                "email" => user.email,
                "createdAt" => user.created_at.iso8601,
                "updatedAt" => user.updated_at.iso8601,
                "archived" => user.archived,
              },
            },
          },
        },
        @response.parsed_body
      )
    end
  end
end
