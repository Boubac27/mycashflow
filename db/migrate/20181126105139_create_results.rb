class CreateResults < ActiveRecord::Migration[5.2]
  def change
    create_table :results do |t|
      t.text :url
      t.integer :deductions
      t.integer :amortization
      t.integer :taxes
      t.references :search, foreign_key: true

      t.timestamps
    end
  end
end
