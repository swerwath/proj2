class CreateEquipment < ActiveRecord::Migration
  def change
    create_table :equipment do |t|
      t.string :name
      t.string :condition
      t.string :user_id
      t.string :team_id

      t.timestamps null: false
    end
  end
end
