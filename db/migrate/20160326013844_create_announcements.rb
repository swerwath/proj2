class CreateAnnouncements < ActiveRecord::Migration
  def change
    create_table :announcements do |t|
      t.string :title
      t.string :content
      t.integer :user_id
      t.integer :team_id

      t.timestamps null: false
    end
  end
end
