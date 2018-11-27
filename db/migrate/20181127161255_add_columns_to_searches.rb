class AddColumnsToSearches < ActiveRecord::Migration[5.2]
  def change
    add_column :searches, :city, :string
    add_column :searches, :zipcode, :string
 end
end
