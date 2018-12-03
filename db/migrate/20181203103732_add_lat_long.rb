class AddLatLong < ActiveRecord::Migration[5.2]
  def change
    add_column :favorites, :lat, :float
    add_column :favorites, :long, :float
  end
end
