class DropProgresses < ActiveRecord::Migration[5.2]
  def change
    drop_table :progresses do |t|
      t.integer :scale
      t.references :user
      t.timestamps null: false
    end
  end
end
