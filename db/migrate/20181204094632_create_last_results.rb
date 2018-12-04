class CreateLastResults < ActiveRecord::Migration[5.2]
  def change
    create_table :last_results do |t|
      t.integer :budget
      t.string :ville
      t.integer :zipcode
      t.string :city

      t.timestamps
    end
  end
end
