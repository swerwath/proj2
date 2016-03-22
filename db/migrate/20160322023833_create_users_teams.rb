class CreateUsersTeams < ActiveRecord::Migration
  def change
    create_table :users_teams, id: false do |t|
      t.belongs_to :user, index: true
      t.belongs_to :team, index: true
    end
  end
end
