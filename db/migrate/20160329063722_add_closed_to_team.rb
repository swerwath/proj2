class AddClosedToTeam < ActiveRecord::Migration
  def change
    add_column :teams, :closed, :boolean
  end
end
