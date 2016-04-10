class CreateClubPresidents < ActiveRecord::Migration
  def change
    create_table :club_presidents do |t|
      t.integer :club_id
      t.integer :user_id
      t.timestamps null: false
    end
  end
end
