class AddEmailBlastToAnnouncement < ActiveRecord::Migration
  def change
    add_column :announcements, :email_blast, :boolean
  end
end
