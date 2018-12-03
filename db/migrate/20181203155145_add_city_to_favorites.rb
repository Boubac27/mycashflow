class AddCityToFavorites < ActiveRecord::Migration[5.2]
  def change
    add_column :favorites, :city, :string
  end
end
