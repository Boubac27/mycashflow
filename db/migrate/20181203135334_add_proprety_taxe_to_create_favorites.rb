class AddPropretyTaxeToCreateFavorites < ActiveRecord::Migration[5.2]
  def change
    add_column :favorites, :property_taxe,  :float
    add_column :favorites, :work,           :float
    add_column :favorites, :insurance,      :float
    add_column :favorites, :total_rent,     :float
    add_column :favorites, :monthy_loan,    :float
    add_column :favorites, :rental_charges, :float
  end
end
