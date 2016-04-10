class RemoveLeaderIdFromTeams < ActiveRecord::Migration
  def change
      remove_column :teams, :leader_id, :integer
  end
end
