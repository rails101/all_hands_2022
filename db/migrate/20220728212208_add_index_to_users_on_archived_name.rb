class AddIndexToUsersOnArchivedName < ActiveRecord::Migration[7.0]
  def change
    add_index :users, :name, where: "NOT archived",
      name: "index_users_on_name_where_not_archived"
  end
end
