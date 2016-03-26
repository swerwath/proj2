class AddClosedToClub < ActiveRecord::Migration
  def change
    add_column :clubs, :closed, :boolean
  end
end
