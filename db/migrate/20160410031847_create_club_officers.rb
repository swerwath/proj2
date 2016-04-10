class CreateClubOfficers < ActiveRecord::Migration
  def change
    create_table :club_officers do |t|
      t.integer :club_id
      t.integer :user_id
      t.timestamps null: false
    end
  end
end
