class CreateSelections < ActiveRecord::Migration[7.0]
  def change
    create_table :selections do |t|
      t.belongs_to :round, null: false, foreign_key: true, index: false
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
      t.index [:round_id, :user_id], unique: true
    end
  end
end
