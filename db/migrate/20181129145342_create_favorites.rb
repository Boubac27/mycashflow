class CreateFavorites < ActiveRecord::Migration[5.2]
  def change
    create_table :favorites do |t|
      t.float :price
      t.float :rendement
      t.integer :rooms
      t.integer :surface
      t.string :urlscrap
      t.string :urlimage
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
