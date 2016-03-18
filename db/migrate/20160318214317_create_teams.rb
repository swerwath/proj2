class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :name
      t.string :description
      t.string :meeting_time
      t.integer :club_id
      t.integer :leader_id

      t.timestamps null: false
    end
  end
end
