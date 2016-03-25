class CreateTeamsUsersJoinTable < ActiveRecord::Migration
  def self.up
    create_table :teams_users, :id => false do |t|
      t.integer :team_id
      t.integer :user_id
    end

    add_index :teams_users, [:team_id, :user_id]
  end

  def self.down
    drop_table :teams_users
  end
end
