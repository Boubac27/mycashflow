class CreateProgresses < ActiveRecord::Migration[5.2]
  def change
    create_table :progresses do |t|
      t.integer :scale
      t.references :user, foreign_key: true
    end
  end
end
