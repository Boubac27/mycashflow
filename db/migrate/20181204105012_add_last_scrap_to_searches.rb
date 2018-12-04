class AddLastScrapToSearches < ActiveRecord::Migration[5.2]
  def change
    add_column :searches, :last_scrap, :datetime
  end
end
