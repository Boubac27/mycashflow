class AddZipcodeToFavorites < ActiveRecord::Migration[5.2]
  def change
    add_column :favorites, :zipcode, :string
  end
end
