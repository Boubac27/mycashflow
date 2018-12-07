class AddAvgRentToFavorites < ActiveRecord::Migration[5.2]
  def change
    add_column :favorites, :avg_rent, :float
  end
end
