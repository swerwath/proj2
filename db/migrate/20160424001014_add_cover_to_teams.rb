class AddCoverToTeams < ActiveRecord::Migration
  def self.up
    add_attachment :teams, :cover
  end

  def self.down
    remove_attachment :teams, :cover
  end
end
