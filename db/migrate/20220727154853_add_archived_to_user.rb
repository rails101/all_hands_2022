class AddArchivedToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :archived, :boolean, null: false, default: false
  end
end
