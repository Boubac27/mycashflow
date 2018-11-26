class CreateSearches < ActiveRecord::Migration[5.2]
  def change
    create_table :searches do |t|
      t.string :zone
      t.integer :budget
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
